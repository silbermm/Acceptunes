defmodule Acceptunes.Scheduler do
  use GenServer
  require Logger

  def start_link(opts \\ []) do
    IO.puts "starting scheduler"
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    schedule()
    Logger.debug "Scheduler started"
    {:ok, %{}}
  end

  def run_and_schedule do
    GenServer.call(__MODULE__, :run)
  end

  def handle_call(:run, _from, state) do
    run()
    {:reply, :ok, state}
  end

  def handle_info(:run, state) do
    run()
    schedule()
    {:noreply, state}
  end

  defp run do
    if RallyServer.is_loaded do
      # Check for new items that have been accepted and play sound
      new? = RallyServer.check_for_new
      if (new? > 0) do
        send_congrats
      end
    end
  end

  defp schedule do
    Process.send_after(self(), :run, 5 * 1000) # In 30 minute
  end

  def send_congrats do
    Acceptunes.Asound.play_sound("yeah.mp3")
    cat = Cats.get_cat
    Slack.post("""
      {
      "text": "<!channel> Congratulations on getting another item through Rally!\n Enjoy this cat picture as a reward!",
      "attachments": [
        {
          "fallback": "Really awesome picture of a cat.",
          "color": "good",
          "image_url": "#{cat}"
        }
      ]
      }
    """)
  end
end
