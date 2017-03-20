use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

config :acceptunes, :rally_api, RallyMock

config :acceptunes,
  rally_api_key: System.get_env("RALLY_API_KEY"),
  rally_workspace_id: System.get_env("RALLY_WORKSPACE_ID"),
  rally_project_id: 27593501023,
  current_timezone: "America/New_York"
