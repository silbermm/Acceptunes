defmodule Acceptunes.Scheduler do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
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
    IO.puts "Checking for new accepted items"
    new? = RallyServer.check_for_new
    if (new? > 0) do
      IO.puts "found a new item!"
      Acceptunes.Asound.play_sound("/home/silbermm/Projects/acceptunes/test/support/R2D2.mp3")
    end

    # Get current count to update screen
    current_count = RallyServer.current_count

    # Push to screen?...
  end

  defp schedule do
    Process.send_after(self(), :run, 30 * 1000) # In 1 minute
  end

end
