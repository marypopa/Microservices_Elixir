defmodule Conference.MixProject do
  use Mix.Project

  def project do
    [
      app: :user,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
	    mod: {User.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.6"},
      {:cowboy, "~> 2.4"},
      {:plug_cowboy, "~> 2.0"},
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"},
      {:poison, "~> 3.0"},
      {:joken, "~> 2.2.0"},
      {:jsonapi, "~> 0.3.0"},
      {:guardian, "~> 2.1.1"},
      {:comeonin, "~> 5.3.1"},
      {:timex, "~> 3.0"},
      {:amqp, "~> 1.0"},
    ]
  end
end
