defmodule Acceptunes.Mixfile do
  use Mix.Project

  def project do
    [app: :acceptunes,
     version: "0.0.7",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Play a tune when a Raly item is accepted",
     aliases: aliases,
     deps: deps,
     package: package]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Acceptunes, []},
     applications: [:phoenix, :phoenix_html,
                    :cowboy, :logger, :gettext,
                    :httpoison, :edeliver, :quantum]]
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
    [{:phoenix, "~> 1.1.3"},
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:httpoison, "~> 0.9.0"},
     {:exrm, "~> 1.0.8"},
     {:edeliver, "~> 1.3.0"},
     {:quantum, ">= 1.7.1"},
     {:credo, "~> 0.4", only: [:dev, :test]},
     {:dialyxir, "~> 0.3.5", only: [:dev]}
   ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
