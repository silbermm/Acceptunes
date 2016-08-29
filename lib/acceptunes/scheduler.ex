defmodule Acceptunes.Scheduler do
  use GenServer
  require Logger

  alias Acceptunes.Asound

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

  def run do
    if RallyServer.loaded? do
      # Check for new items that have been accepted and play sound
      new? = RallyServer.check_for_new
      if new? > 0 do
        send_congrats(RallyServer.current_count)
      end
    end
  end

  defp schedule do
    Process.send_after(self(), :run, 5 * 1000) #Every 5 seconds
  end

  def send_congrats(_number_accepted \\ 1) do
    Asound.play_sound("yeah.mp3")
    cats()
  end

  def cats do
    cat = Cats.get_cat
    attachment = %SlackAttachment{fallback: "Really awesome picture of a cat", image_url: cat}
    message = %SlackMessage{text: "<!channel> Congratulations on getting another item through Rally!\n Enjoy this cat picture as a reward!",
                             attachments: [attachment]
                           }
    Slack.post(message)
  end

  def chuck_norris do
    quote = ChuckNorris.get_joke
    attachment = %SlackAttachment{ 
      fallback: "CHUCK NORRIS!",
      image_url: nil,
      text: quote,
      author_icon: "http://theheureka.com/wp-content/uploads/2012/05/got-99-problems-chuck-norris-has-none.jpeg",
      author_name: "Chuck Norris"
    }
    message = %SlackMessage{
      text: "<!channel> Congratulations on getting another item through Rally! Enjoy a new Chuck Norris joke!",
      attachments: [attachment]
    }
    Slack.post(message)
  end
end
