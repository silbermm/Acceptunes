defmodule Acceptunes.RallyController do
  use Acceptunes.Web, :controller

  def index(conn, params) do
    IO.inspect params
    conn
      |> send_resp(200, "")
  end
end
