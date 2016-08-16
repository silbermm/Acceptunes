defmodule Acceptunes.RallyController do
  use Acceptunes.Web, :controller

  def index(conn, _params) do
    conn
      |> send_resp(200, "")
  end
end
