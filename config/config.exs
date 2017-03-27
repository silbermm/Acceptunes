use Mix.Config

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :acceptunes,
  rally_api_key: System.get_env("RALLY_API_KEY"),
  rally_workspace_id: System.get_env("RALLY_WORKSPACE_ID"),
  rally_project_id: System.get_env("RALLY_PROJECT_ID"),
  current_timezone: "America/New_York",
  asound_location: "/usr/bin/play",
  asound_options: [],
  slack_url: System.get_env("ACCEPTUNES_SLACK_WEBHOOK")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
