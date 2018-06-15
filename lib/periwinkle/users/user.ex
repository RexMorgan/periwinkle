defmodule Periwinkle.Users.User do
  use Periwinkle.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email_address, :string, source: :email)
    field(:first_name, :string, source: :firstname)
    field(:last_name, :string, source: :lastname)
    field(:phone_number, :string, source: :phone)
    field(:status, :string)
    field(:workgroup, :string)
    field(:department, :string)
    field(:time_zone, :string, source: :timezone)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end
end