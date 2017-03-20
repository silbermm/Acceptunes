defmodule Acceptunes.Mixfile do
  use Mix.Project

  def project do
    [app: :acceptunes,
     version: "0.0.7",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Play a tune when a Rally item is accepted",
     deps: deps,
     package: package]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Acceptunes, []},
     applications: [:logger, :httpoison, :edeliver, :quantum]]
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
    [{:httpoison, "~> 0.9.0"},
     {:exrm, "~> 1.0.8"},
     {:poison, "~> 3.0"},
     {:edeliver, "~> 1.3.0"},
     {:quantum, ">= 1.7.1"},
     {:credo, "~> 0.7.0", only: [:dev, :test]},
     {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
   ]
  end
end
