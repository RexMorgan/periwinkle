defmodule Periwinkle.Resolvers.Labels do
  alias Periwinkle.Labels.Label
  
  alias Periwinkle.Workflow.Case

  alias Periwinkle.Repo

  import Ecto.Query

  def labels_for_case(%Case{id: id}, _args, _resolution) do
    query = from l in Label,
            where: l.entityid == ^id and l.value != ^""

    labels = Repo.all(query)
    |> label_to_string
    
    {:ok, labels}
  end

  defp label_to_string([]), do: []
  defp label_to_string(labels) do
    labels |> Enum.map(fn(x) -> x.value end)
  end
end