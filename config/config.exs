import Config

config :user, User.Plug.Token,
  issuer: "auth",
  secret_key: "P/jz2iPmwm+BFkpoparQHO6ULWwuTzAqgVEojdpK5x/aK3rXrOshMwy+OE5/90nS",
  ttl: {30, :days},
  allowed_drift: 2000

config :user, ecto_repos: [User.Repository.Repo]

config :user, User.Repository.Repo,
       username: "postgres",
       password: "postgres",
       database: "User",
       hostname: "userDb",
       port: "5433",
       show_sensitive_data_on_connection_error: true
