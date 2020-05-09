defmodule User.Repository.Repo do
  import Bcrypt

  alias User.Model.User, as: MUser
  alias User.Repository.Repo, as: Repo

  use Ecto.Repo,
      otp_app: :user,
      adapter: Ecto.Adapters.Postgres

  def get_user_sign_up(params) do
    %MUser{}
    |> MUser.changeset(params)
    |> Ecto.Changeset.change(add_hash(params["password"]))
    |> Repo.insert()
  end
end
