# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :game_api,
  ecto_repos: [GameApi.Repo]

# Configures the endpoint
config :game_api, GameApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GLA/aFcCg/iBeW9nQNfjEZzzlqUV7OVshRpjUcyikuveA2/7w8A/odq6iLevC/iy",
  render_errors: [view: GameApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GameApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
