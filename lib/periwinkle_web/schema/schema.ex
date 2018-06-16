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

      resolve(&Resolvers.Workflow.update_case/3)
    end

    field :add_note, type: :activity_log do
      arg :case_id, non_null(:id)
      arg :notes, non_null(:string)

      resolve(&Resolvers.Workflow.add_note/3)
    end
  end

  subscription do
    field :monitor_case, type: :case do
      arg :id, non_null(:id)

      # Configure the subscription, setting the topic fn based on the provided case Id arg
      config fn args, _ ->
        {:ok, topic: args.id}
      end

      # Auto-trigger on update_case mutation
      # This tells Absinthe to run any subscriptions with this field every time
      # the :update_case mutation happens.
      # It also has a topic function used to find what subscriptions care about
      # this particular case
      trigger :update_case, topic: fn c ->
        c.id
      end

      trigger :add_note, topic: fn note ->
        note.case.id
      end
    end
  end
end