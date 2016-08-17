defmodule Slack do

  @webhook_url Application.get_env(:acceptunes, :slack_url)

  def post(payload) do
    response = HTTPoison.post(@webhook_url, payload,
      %{"Content-type" => "application/x-www-form-urlencoded"})

    case response do
      {:ok, res } ->
        res.status_code == 200
      {:error, err } ->
        false
    end
  end
end
