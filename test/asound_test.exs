defmodule AsoundTest do
  use ExUnit.Case

  @sound_dir Application.get_env(:acceptunes, :sound_directory)

  @tag external: true
  test "sound plays successfully" do
    assert Acceptunes.Asound.play_sound("yeah.mp3") == true
  end

  @tag external: true
  test "unknown file does not play" do
    assert Acceptunes.Asound.play_sound("#{@sound_dir}/yeah.3") == false
  end


end
