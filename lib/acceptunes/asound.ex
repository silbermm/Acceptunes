defmodule Acceptunes.Asound do
  @asound Application.get_env(:acceptunes, :asound_location)
  @asound_options Application.get_env(:acceptunes, :asound_options, [])
  @sound_dir Application.get_env(:acceptunes, :sound_directory)

  def play_sound(file) do
    file = "#{@sound_dir}/#{file}"
    options = @asound_options ++ [ file ]
    case System.cmd(@asound, options) do
      {_, 0} -> true
      {_, _} -> false
    end
  end
end
