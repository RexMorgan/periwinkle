defmodule Periwinkle.Resolvers.Lists do
  alias Periwinkle.Lists.ListValue

  alias Periwinkle.Repo

  import Ecto.Query

  def get_list_values(_parent, %{list_name: list_name}, _resolution) do
    query = from v in ListValue,
            where: v.list_name == ^list_name
    {:ok, Repo.all(query)}
  end
end