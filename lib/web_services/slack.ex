defmodule Slack do

  @webhook_url Application.get_env(:acceptunes, :slack_url)

  def post(payload) do
    post_data = payload |> Poison.encode!
    response = HTTPoison.post(@webhook_url, post_data,
      %{"Content-type" => "application/json"})

    case response do
      {:ok, res } ->
        res.status_code == 200
      {:error, err } ->
        IO.inspect err
        false
    end
  end
end
