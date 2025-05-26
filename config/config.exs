# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :brs,
  ecto_repos: [Brs.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :brs, BrsWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: BrsWeb.ErrorHTML, json: BrsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Brs.PubSub,
  live_view: [signing_salt: "hed7Bn6R"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :brs, Brs.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ],
  custom_output: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/output.css
      --output=../priv/static/assets/output.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :brs, BrsWeb.SingleSignon,
  base_url: "https://demo.accounts.pesaflow.com",
  client_id: "b67c5d5fa5b00f6c996461c6321afa09",
  client_secret: "uVJxCHuBKdZJlaVIUqQIXVzEiUYjURnp",
  oauth2_client: OAuth2.Client,
  auth_type: :oauth,
  redirect_uri: "http://localhost:4000/auth/login/sso/callback",
  authorize_url: "/oauth/authorize",
  token_url: "/oauth/access-token",
  user_info_url: "/api/user-info"

config :brs, Brs.HTTPClient,
  adapter: HTTPoison,
  adapter_options: [
    recv_timeout: 30_000
  ]

config :brs, Timex, timezone: "Africa/Nairobi"
config :brs, timezone: "Africa/Nairobi"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
