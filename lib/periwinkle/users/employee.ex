defmodule Periwinkle.Users.Employee do
  use Periwinkle.Schema
  import Ecto.Changeset

  schema "employee" do
    field(:title, :string)
    field(:first_name, :string, source: :firstname)
    field(:last_name, :string, source: :lastname)
    field(:job_title, :string, source: :jobtitle)
    field(:status, :string)
    field(:phone_number, :string, source: :primaryphonenumber)
    field(:email_address, :string, source: :primaryemailaddress)
    field(:time_zone, :string, source: :timezone)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end
end