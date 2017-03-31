defmodule Acceptunes.Mixfile do
  use Mix.Project

  def project do
    [app: :acceptunes,
     version: "0.0.9",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Play a tune when a Rally item is accepted",
     deps: deps(),
     package: package()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Acceptunes, []},
     applications: [:logger, :httpoison, :edeliver, :poison, :timber]]
  end

  def package do
    [
      external_dependencies: [],
      license_file: "LICENSE",
      files: [ "lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["Matt Silbernagel <silbermm@gmail.com>"],
      licenses: ["MIT"],
      vendor: "Matt Silbernagel",
      links:  %{
        "GitHub" => "https://github.com/silbermm/acceptunes"
      }
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:httpoison, "~> 0.11.1"},
     {:distillery, "~> 1.0"},
     {:poison, "~> 3.1.0"},
     {:edeliver, "~> 1.4.2"},
     {:credo, "~> 0.7.1", only: [:dev, :test]},
     {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
     {:timber, "~> 1.0"}
   ]
  end
end
