defmodule PeriwinkleWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Periwinkle.Repo

  import_types Absinthe.Type.Custom

  object :case do
    field(:id, :id)
    field(:title, :string)
    field(:status, :string)
    field(:priority, :string)
    field(:severity, :string)
    field(:case_type, :string)
    field(:origin, :string)
    field(:available_in_self_service, :boolean)
    field(:is_sensitive, :boolean)
    field(:employee, :employee, resolve: assoc(:employee))
    field(:created, :naive_datetime)
    field(:lastmodified, :naive_datetime)
  end

  object :employee do
    field(:id, :id)
    field(:title, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:full_name, :string)
    field(:job_title, :string)
    field(:status, :string)
    field(:phone_number, :string)
    field(:email_address, :string)
    field(:time_zone, :string)
    field(:created, :naive_datetime)
    field(:lastmodified, :naive_datetime)
  end

  object :list_value do
    field(:id, :id)
    field(:list_name, :string)
    field(:value, :string)
    field(:order, :integer)
    field(:active, :boolean)
    field(:is_default, :boolean)
    field(:integration_id, :string)
    field(:parent_id, :id)
  end
end