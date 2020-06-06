defmodule User.Application do
  use Application

  def start(_type, _args) do   
    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      {
        Plug.Adapters.Cowboy,
        scheme: :http,
        plug: User.Plug.Router,
        options: [
          port: 8080
        ]
      },
      User.Repository.Repo
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: User.Supervisor
    ]
  end
end