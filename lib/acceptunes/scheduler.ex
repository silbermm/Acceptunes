defmodule Acceptunes.Scheduler do
  @moduledoc """
  Schedules calls to rally every 5 seconds
  """
  use GenServer
  require Logger
  require IEx

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
      new_accepted = RallyServer.check_for_new
      send_congrats(new_accepted)
    end
  end

  defp schedule do
    Process.send_after(self(), :run, 5 * 1000) #Every 5 seconds
  end

  def send_congrats(0), do: nil
  def send_congrats(_number_accepted) do
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
