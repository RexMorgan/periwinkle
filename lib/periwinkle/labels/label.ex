defmodule Periwinkle.Labels.Label do
  use Periwinkle.Schema
  import Ecto.Changeset

  alias Periwinkle.Workflow.Case

  schema "globallabel" do
    field(:value, :string, source: :labelvalue)

    belongs_to(:case, Case, foreign_key: :entityid)

    timestamps(inserted_at: :created, updated_at: :lastmodified)
  end
end