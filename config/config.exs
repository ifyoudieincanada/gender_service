# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gender_service,
  ecto_repos: [GenderService.Repo]

# Configures the endpoint
config :gender_service, GenderService.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1XLFCjCNi1hcK+kxBgbUQmdJ7q9zljh5ZrDV58bQp4XMnQB1MRfgZ10hzppwD3jT",
  render_errors: [view: GenderService.ErrorView, accepts: ~w(json)],
  pubsub: [name: GenderService.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :user_client,
  url: System.get_env("USER_SERVICE_URL")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
