defmodule AsoundTest do
  use ExUnit.Case

  test "sound plays successfully" do
    assert Asound.play_sound("/home/silbermm/Projects/acceptunes/test/support/r2d2.mp3") == true
  end

end
