defmodule PeriwinkleWeb.Schema do
  use Absinthe.Schema
  import_types(PeriwinkleWeb.Schema.Types)

  query do
    field :cases, type: list_of(:case) do
      resolve(&Periwinkle.Workflow.CaseResolver.all/2)
    end
  end
end