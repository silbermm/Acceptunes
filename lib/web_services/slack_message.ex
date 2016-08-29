defmodule SlackMessage do

  @derive [Poison.Encoder]
  defstruct text: "<!channel>·Congratulations·on·getting·another·item·through·Rally!",
            channel: nil,
            attachments: []
end

defmodule SlackAttachment do
  @derive [Poison.Encoder]
  defstruct fallback: "", color: "good", image_url: nil, text: nil, author_name: nil, author_icon: nil
end
