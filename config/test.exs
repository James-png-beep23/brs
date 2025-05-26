import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :brs, Brs.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "brs_test",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :brs, BrsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "VoG1mSaZJzpe2r5lUKu0hacGy2bBRSf3MrY9GayABSyoBiT9eGB7ZCAE27f2N+iZ",
  server: false

# In test we don't send emails.
config :brs, Brs.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Finally import the config/test.local.exs which should NOT be versioned
import_config "test.local.exs"
