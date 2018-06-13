defmodule Periwinkle.Workflow.Case do
  @moduledoc false
  use Periwinkle.Schema

  schema "case" do
    field :title, :string
    field :description, :string
    field :status, :string
    field :public, :boolean
    timestamps()
  end
end
