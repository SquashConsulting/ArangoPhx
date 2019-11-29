# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

endpoint =
  System.get_env("DATABASE_ENDPOINT") ||
    raise """
    environment variable DATABASE_ENDPOINT is missing.
    """

config :arango_phx, ArangoPhx.Repo,
  # ssl: true,
  endpoints: endpoint,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :arango_phx, ArangoPhxWeb.Endpoint,
  # inet6 is ipv6, set it to inet for ipv4
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :arango_phx, ArangoPhxWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
