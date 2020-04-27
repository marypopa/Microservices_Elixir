defmodule User.Plug.AuthController do
  use Plug.Router
  import Plug.Conn

  require Logger

  plug :match
  plug :dispatch

  post "/signup" do
    old_user = User.Repository.Repo.get_by(User.Model.User, email: conn.body_params["email"])
    case old_user do
      nil -> conn
             |> put_resp_content_type("application/json")
             |> send_resp(200, Poison.encode!(User.Repository.Repo.get_user_sign_up(conn.body_params)))
      _ -> conn
           |> put_resp_content_type("application/json")
           |> send_resp(400, "Email address already in use.")
    end
  end

end
