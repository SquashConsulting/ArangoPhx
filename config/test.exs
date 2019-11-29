use Mix.Config

# Configure your database
config :arango_phx, ArangoPhx.Repo,
  database: "arango_phx_test",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :arango_phx, ArangoPhxWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
