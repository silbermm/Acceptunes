defmodule RallyServer do
  use GenServer
  require Logger
  
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
    GenServer.call(__MODULE__, {:check})
  end

  ## Server Callbacks
  def init(:ok) do
    # get intial daily accepted items
    Logger.info "Starting RallyServer for project #{@rally_project_id}"
    rally_result = DailyRallyItems.get(@rally_project_id)
    {:ok, %{:current_count => rally_result.total_results, :loaded => true}}
  end

  def handle_call({:is_loaded}, _from, state) do
    {:reply, Map.get(state,:loaded, false) , state}
  end

  def handle_call({:current_count}, _from, state) do
    {:reply, state.current_count , state}
  end

  def handle_call({:check}, _from, %{:loaded => true} = state) do
    rally_result = DailyRallyItems.get(@rally_project_id)
    if rally_result.status_code == 200 do
      {
        :reply,
        rally_result.total_results - state.current_count,
        %{state | :current_count => rally_result.total_results}
      }
    else
      {
        :reply,
        0,
        state
      }
    end
  end

  def handle_call({:check}, _from, state) do
    rally_result = DailyRallyItems.get(@rally_project_id)
    {
      :reply,
      0,
      %{:current_count => rally_result.total_results, :loaded => true}
    }
  end

  def handle_cast({:clear_count}, _state) do
    {:noreply, %{:current_count => 0}}
  end

end
