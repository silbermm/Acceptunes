defmodule RallyServerTest do
  use ExUnit.Case

  test "sets up initial rally server" do
    assert RallyServer.current_count == 2
  end

  test "clears state in rally server" do
    RallyServer.clear
    assert RallyServer.current_count == 0
  end

  test "checks for new rally items" do
    new = RallyServer.check_for_new
    assert new == 0
  end

end
