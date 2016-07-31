defmodule Acceptunes.PageController do
  use Acceptunes.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
