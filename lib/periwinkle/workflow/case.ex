defmodule Periwinkle.Workflow.Case do
  @moduledoc false
  use Periwinkle.Schema
  import Ecto.Changeset

  schema "case" do
    field(:identifier, :string)
    field(:title, :string)
    field(:status, :string, default: "Open")
    field(:priority, :string)
    field(:severity, :string, source: :issueseverity)
    field(:case_type, :string, source: :casetype)
    field(:origin, :string)

    field(:available_in_self_service, :boolean, default: false, source: :availableinselfservice)
    field(:is_sensitive, :boolean, default: true, source: :issensitive)

    belongs_to(:employee, Employee)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end

  def changeset(case, attrs) do
    case
    |> cast(attrs, [])
    |> validate_required([])
  end
end
