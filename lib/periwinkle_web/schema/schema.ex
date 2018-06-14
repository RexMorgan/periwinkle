defmodule PeriwinkleWeb.Schema do
  use Absinthe.Schema

  alias Periwinkle.Resolvers

  import_types(PeriwinkleWeb.Schema.Types)

  query do
    field :cases, type: list_of(:case) do
      resolve(&Resolvers.Workflow.get_cases/3)
    end

    field :case, type: :case do
      arg :id, non_null(:id)
      resolve(&Resolvers.Workflow.get_case/3)
    end

    field :employee_search, type: list_of(:employee) do
      arg :search, non_null(:string)
      resolve(&Resolvers.Users.search_employee/3)
    end
  end
end