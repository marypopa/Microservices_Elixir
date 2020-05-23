defmodule User.Plug.Token do
    use Guardian, otp_app: :user
    alias User.Repository.Repo, as: Repo
    alias User.Model.User, as: MUser

    def subject_for_token(user, _claims) do
        {:ok, to_string(user.id)}
    end

    def resource_from_claims(claims) do
        id=claims["sub"]
        user = Repo.get(MUser,id)
        {:ok, user}
    rescue
        Ecto.NoResultsError -> {:error, :resource_not_found}
    end
end