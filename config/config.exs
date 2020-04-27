import Config

config :user, ecto_repos: [User.Repository.Repo]

config :user, User.Repository.Repo,
       username: "postgres",
       password: "admin",
       database: "User",
       hostname: "localhost",
       port: "5432",
       show_sensitive_data_on_connection_error: true
