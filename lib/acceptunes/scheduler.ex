defmodule Acceptunes.Scheduler do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    run()
    schedule()
    {:ok, %{}}
  end

  def handle_info(:run, state) do
    run()
    schedule()
    {:noreply, state}
  end

  defp run do
    # Check for new items that have been accepted and play sound
    new? = RallyServer.check_for_new
    if (new? > 0) do
      IO.puts "found a new item!"
      Acceptunes.Asound.play_sound("/home/silbermm/Projects/acceptunes/test/support/r2d2.mp3")
    end

    # Get current count to update screen
    current_count = RallyServer.current_count

    # Push to screen?...
    Acceptunes.RoomChannel.update_rally_count(current_count)
  end

  defp schedule do
    Process.send_after(self(), :run, 30 * 1000) # In 1 minute
  end

end
