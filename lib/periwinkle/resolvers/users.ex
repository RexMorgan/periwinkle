defmodule Periwinkle.Resolvers.Users do
  alias Periwinkle.Users.Employee

  alias Periwinkle.Repo

  import Ecto.Query

  def search_employee(_parent, %{search: search}, _resolution) do
    query = from e in Employee,
            where: ilike(e.full_name, ^"%#{search}%")
     {:ok, Repo.all(query)}
  end
end