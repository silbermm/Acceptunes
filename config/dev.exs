use Mix.Config

config :acceptunes, :rally_api, Rally

config :acceptunes,
  rally_api_key: System.get_env("RALLY_API_KEY"),
  rally_workspace_id: System.get_env("RALLY_WORKSPACE_ID"),
  current_timezone: "America/New_York",
  asound_options: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
