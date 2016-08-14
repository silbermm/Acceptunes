defmodule RallyServer do
  use GenServer

  @rally_project_id Application.get_env(:acceptunes, :rally_project_id)

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def current_count do
    GenServer.call(__MODULE__, {:current_count})
  end

  def is_loaded do
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
    rally_result = Acceptunes.DailyRallyItems.get(@rally_project_id)
    Acceptunes.RoomChannel.update_rally_count(rally_result.total_results)
    Acceptunes.Scheduler.start_link([[name: Acceptunes.Scheduler]])
    {:ok, %{:current_count => rally_result.total_results, :loaded => true }}
  end

  def handle_call({:is_loaded}, _from, state) do
    {:reply, Map.get(state,:loaded, false) , state}
  end

  def handle_call({:current_count}, _from, state) do
    {:reply, state.current_count , state}
  end

  def handle_call({:check}, _from, %{:loaded => true} = state) do
    rally_result = Acceptunes.DailyRallyItems.get(@rally_project_id)
    Acceptunes.RoomChannel.update_rally_count(rally_result.total_results)
    {
      :reply,
      rally_result.total_results - state.current_count,
      %{state | :current_count => rally_result.total_results}
    }
  end

  def handle_call({:check}, _from, state) do
    rally_result = Acceptunes.DailyRallyItems.get(@rally_project_id)
    Acceptunes.RoomChannel.update_rally_count(rally_result.total_results)
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
