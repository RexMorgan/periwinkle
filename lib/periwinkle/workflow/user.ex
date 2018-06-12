defmodule Periwinkle.Workflow.User do
  @moduledoc false
  use Periwinkle.Schema

  import Ecto.Changeset

  schema "user" do
    field :username, :string
    field :password, :string
    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:username, :password])
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
