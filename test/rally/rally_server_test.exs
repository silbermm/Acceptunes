defmodule RallyServerTest do
  use ExUnit.Case

  test "sets up initial rally server" do
    if (RallyServer.is_loaded) do
      assert RallyServer.current_count == 2
    else
      assert RallyServer.current_count == 0
    end
  end

  test "calls rally api endpoint on first check and sets loaded" do
    new = RallyServer.check_for_new
    if (RallyServer.is_loaded) do
      assert RallyServer.current_count == 2
      assert new == 0
    else
      assert RallyServer.current_count == 0
      assert new == 2
    end 
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
