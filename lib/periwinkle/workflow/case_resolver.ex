defmodule Periwinkle.Workflow.CaseResolver do
  alias Periwinkle.Workflow.Case

  alias Periwinkle.Repo

  def all(_args, _context) do
    {:ok, Repo.all(Case)}
  end
end