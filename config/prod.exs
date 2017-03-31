use Mix.Config
config :acceptunes, :rally_api, Rally

config :acceptunes,
  rally_api_key: System.get_env("RALLY_API_KEY"),
  rally_workspace_id: System.get_env("RALLY_WORKSPACE_ID"),
  rally_project_id: System.get_env("RALLY_PROJECT_ID"),
  current_timezone: "America/New_York"

# Do not print debug messages in production
config :logger, level: :info
