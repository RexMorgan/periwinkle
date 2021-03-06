defmodule Periwinkle.Workflow.Case do
  @moduledoc false
  use Periwinkle.Schema

  alias Periwinkle.Labels.Label

  alias Periwinkle.Users.Employee
  alias Periwinkle.Users.User

  alias Periwinkle.Workflow.ActivityLog

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
    belongs_to(:owner, User)

    has_many(:activity_logs, ActivityLog, foreign_key: :workflowitem_id)
    has_many(:labels, Label, foreign_key: :entityid)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end

  def changeset(case, attrs) do
    case
    |> cast(attrs, [])
    |> validate_required([])
  end
end
