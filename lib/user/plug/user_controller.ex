defmodule User.Plug.UserController do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(User.Repository.Repo.all(User.Model.User)))
  end


end
