defmodule Cats do
  require Logger

  def get_cat do
    response = HTTPoison.get("http://thecatapi.com/api/images/get?format=src")
    case response do
      {:ok, resp} ->
        resp.headers
          |> Enum.find({"Location", "https://http.cat/404"}, fn(header) ->
            elem(header,0) == "Location"
          end)
          |> elem(1)
      {:error, err} ->
        Logger.error(err)
    end
  end
end
