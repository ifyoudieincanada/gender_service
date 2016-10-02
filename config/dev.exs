use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :gender_service, GenderService.Endpoint,
  http: [port: 4002],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []


# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :gender_service, GenderService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "gender_service",
  password: "gender_service_pass",
  database: "gender_service_dev",
  hostname: "localhost",
  pool_size: 10
