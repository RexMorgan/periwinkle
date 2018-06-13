defmodule PeriwinkleWeb.CaseController do
  use PeriwinkleWeb, :controller

  alias Periwinkle.Workflow.Case
  alias Periwinkle.Repo

  def index(conn, _params) do
    render conn, "index.json", cases: Repo.all(Case)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Case, id) do
      nil -> {:error, "Case ID #{id} not found"}
      case -> render conn, "show.json", case: case
    end
  end
end