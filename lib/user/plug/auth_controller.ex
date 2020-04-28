defmodule User.Plug.AuthController do
  use Plug.Router
  import Plug.Conn

  alias User.Model.User, as: MUser
  alias User.Repository.Repo, as: Repo
  require Logger

  plug :match
  plug :dispatch

  post "/signup" do
    case Repo.get_by(MUser, email: conn.body_params["email"]) do
      nil -> {:ok, new_user} = Repo.get_user_sign_up(conn.body_params)
             conn
             |> put_resp_content_type("application/json")
             |> send_resp(200, Poison.encode!(new_user))
      _ -> send_resp(conn, 400, "Email address already in use.")
    end
  end

end
