defmodule Periwinkle.Resolvers.Workflow do
  import Ecto.{Changeset, Query}

  alias Periwinkle.Workflow.ActivityLog
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

  def update_case(_parent, %{id: id, title: title}, _resolution) do
    case Repo.get(Case, id) do
      %Case{} = case ->
        case
        |> cast(%{title: title}, [:title])
        |> Repo.update()
      _ ->
        {:error, "Case ID #{id} not found"}
    end
  end

  def add_note(_parent, %{case_id: case_id, notes: notes}, _resolution) do
    case Repo.get(Case, case_id) do
      %Case{} = case ->
        %ActivityLog{}
        |> cast(%{notes: notes}, [:notes])
        |> put_assoc(:case, case)
        |> put_change(:type, "Notes")
        |> Repo.insert()
      _ ->
        {:error, "Case ID #{case_id} not found"}
    end
  end
end