defmodule Periwinkle.Resolvers.Workflow do
  alias Periwinkle.Workflow.Case

  alias Periwinkle.Repo

  def get_case(_parent, %{id: id}, _resolution) do
    case Repo.get(Case, id) do
      nil -> {:error, "Case ID #{id} not found"}
      case -> {:ok, case}
    end
  end

  def get_cases(_parent, _args, _resolution) do
    {:ok, Repo.all(Case)}
  end
end