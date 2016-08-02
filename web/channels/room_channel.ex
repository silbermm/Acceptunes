defmodule Acceptunes.RoomChannel do
  use Phoenix.Channel

  def join("room:rally", _message, socket) do
    {:ok, socket}
  end

  def update_rally_count(count) do
    Acceptunes.Endpoint.broadcast("room:rally", "new_accepted", %{:count => count})
  end

  def handle_out("new_accepted", payload, socket) do
    IO.puts "handling out"
    push socket, "new_accepted", payload
    {:noreply, socket}
  end

end
