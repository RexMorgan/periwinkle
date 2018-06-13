defmodule PeriwinkleWeb.CaseController do
  use PeriwinkleWeb, :controller

  alias Periwinkle.Repo

  def index(conn, _params) do
    render conn, "index.json", cases: Repo.all(Periwinkle.Workflow.Case)
  end
end