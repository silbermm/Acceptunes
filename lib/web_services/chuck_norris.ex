defmodule ChuckNorris do
  require Logger

  def get_joke do
    response = HTTPoison.get("http://api.icndb.com/jokes/random?limitTo=[nerdy]")
    case response do 
      {:ok, resp} ->
        rs = resp.body 
              |> Poison.decode!
        rs["value"]["joke"]
      {:error, err} ->
        Logger.error(err.reason)
    end
  end

end
