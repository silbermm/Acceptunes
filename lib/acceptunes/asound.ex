defmodule Acceptunes.Asound do
  @moduledoc """
  Plays sounds
  """
  @asound Application.get_env(:acceptunes, :asound_location)
  @asound_options Application.get_env(:acceptunes, :asound_options, [])

  def play_sound(file) do
    file = :acceptunes
           |> :code.priv_dir
           |> Path.join("sounds")
           |> Path.join(file)
    options = @asound_options ++ [file]
    case System.cmd(@asound, options) do
      {_, 0} -> true
      {_, _} -> false
    end
  end
end
