defmodule User.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :affiliation, :email]}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :affiliation, :string
    field :email, :string
    field :password, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :first_name, :last_name, :affiliation, :email, :password])
  end
end
