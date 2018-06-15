defmodule Periwinkle.Workflow.ActivityLog do
  @moduledoc false
  use Periwinkle.Schema
  
  alias Periwinkle.Users.User

  alias Periwinkle.Workflow.Case

  import Ecto.Changeset

  schema "activitylog" do
    field(:type, :string)
    field(:internal, :boolean)
    field(:notes, :string, source: :notes_plaintext)
    
    belongs_to(:case, Case, foreign_key: :workflowitem_id)
    belongs_to(:user, User)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end

  def changeset(case, attrs) do
    case
    |> cast(attrs, [])
    |> validate_required([])
  end
end
