defmodule User.Plug.AuthController do
  use Plug.Router
  import Plug.Conn
  import Bcrypt
  alias User.Model.User, as: MUser
  alias User.Repository.Repo, as: Repo
  alias User.Plug.RabbitmqProducer, as: Rabbit
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
  post "/login" do
    {email, password} = { conn.body_params["email"],conn.body_params["password"]}
    user =  Repo.get_by(MUser, email: email)
    cond do
      is_nil(user) ->
        conn
        |> put_status(400)
        |> assign(:jsonapi, %{"error" => "credentials are not good"})
        |> send_resp(400,  Poison.encode!(%{"error" => "Credetials not good"}))
      true ->
        case verify_pass(password, user.password_hash) do
          true ->  {:ok,token, full_claims} = User.Plug.Token.encode_and_sign(user)
                    Rabbit.send_message(user, token)
                    conn
                    |> put_resp_content_type("application/json")
                    |> send_resp(200,  Poison.encode!(%{"token" => token}))
          _ -> conn
              |> put_status(400)
              |> assign(:jsonapi, %{"error" => "credentials are not good"})
              |> send_resp(400,  Poison.encode!(%{"error" => "Credetials not good"}))
        end
        end
      end

end
