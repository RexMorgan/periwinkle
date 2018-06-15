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

    field :list_values, type: list_of(:list_value) do
      arg :list_name, non_null(:string)
      resolve(&Resolvers.Lists.get_list_values/3)
    end
  end

  mutation do
    field :update_case, type: :case do
      arg :id, non_null(:id)
      arg :title, non_null(:string)

      resolve &Resolvers.Workflow.update_case/3
    end
  end
end