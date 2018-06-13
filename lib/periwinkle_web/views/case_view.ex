defmodule PeriwinkleWeb.CaseView do
  use PeriwinkleWeb, :view

  alias Periwinkle.Workflow.Case

  def render("index.json", %{cases: cases}) do
    %{cases: Enum.map(cases, &render_case/1)}
  end

  def render("show.json", %{case: case}) do
    render_case(case)
  end

  defp render_case(%Case{} = case) do
    %{
      id: case.id,
      title: case.title,
      status: case.status,
      priority: case.priority,
      severity: case.severity,
      case_type: case.case_type,
      origin: case.origin,
      is_sensitive: case.is_sensitive,
      available_in_self_service: case.available_in_self_service,
      created: case.created,
      updated: case.lastmodified
    }
  end
end
