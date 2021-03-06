defmodule RallyServer do
  @moduledoc """
  Handles calls to the Rally Service
  """
  use GenServer
  require Logger
  require IEx
  alias Acceptunes.RoomChannel
  alias Acceptunes.DailyRallyItems

  @rally_project_id Application.get_env(:acceptunes, :rally_project_id)

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def current_count do
    GenServer.call(__MODULE__, {:current_count})
  end

  def loaded? do
    GenServer.call(__MODULE__, {:is_loaded})
  end

  def clear do
    GenServer.cast(__MODULE__, {:clear_count})
  end

  def check_for_new do
    GenServer.call(__MODULE__, {:check}, 10000)
  end

  ## Server Callbacks
  def init(:ok) do
    # get intial daily accepted items
    rally_result = DailyRallyItems.get(@rally_project_id)
    {:ok, %{:current_count => rally_result.total_results, :loaded => true}}
  end

  def handle_info({:DOWN, ref, :process, pid, reason}, _from, state) do
    Logger.error("Catching down message from #{__MODULE__}: #{reason}")
    {:noreply, state}
  end

  def handle_call({:is_loaded}, _from, state) do
    {:reply, Map.get(state,:loaded, false) , state}
  end

  def handle_call({:current_count}, _from, state) do
    {:reply, state.current_count , state}
  end

  def handle_call({:check}, _from, %{:loaded => true} = state) do
    rally_result = DailyRallyItems.get(@rally_project_id)
    case rally_result.status_code do
      200 -> {:reply,
        rally_result.total_results - state.current_count,
        %{state | :current_count => rally_result.total_results}}
      _ -> {:reply, 0, state}
    end
  end

  def handle_call({:check}, _from, state) do
    rally_result = DailyRallyItems.get(@rally_project_id)
    {:reply, 0, %{:current_count => rally_result.total_results, :loaded => true}}
  end

  def handle_cast({:clear_count}, _state) do
    {:noreply, %{:current_count => 0}}
  end

end
