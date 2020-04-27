defmodule User.Repository.Repo do
  import Bcrypt
  use Ecto.Repo,
      otp_app: :user,
      adapter: Ecto.Adapters.Postgres

  def get_user_sign_up(params) do
    user = User.Model.User.changeset(%User.Model.User{}, params)
           |> Ecto.Changeset.change(add_hash(params["password"]))
    {:ok, inserted} = User.Repository.Repo.insert(user)
    inserted
  end
end
