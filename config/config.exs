# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :periwinkle,
  ecto_repos: [Periwinkle.Repo]

# Configures the endpoint
config :periwinkle, PeriwinkleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "37z61DJkSrdwDglUPV0tosp8bKgXk0Y++bn86P0heTmfrKt7pWr03ajYWiGq1OCH",
  render_errors: [view: PeriwinkleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Periwinkle.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
