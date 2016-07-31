use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :acceptunes, Acceptunes.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :acceptunes, :rally_api, RallyMock

# Configure your database
config :acceptunes, Acceptunes.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "acceptunes_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
