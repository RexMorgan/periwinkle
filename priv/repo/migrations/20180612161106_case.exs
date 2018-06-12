defmodule Periwinkle.Repo.Migrations.Case do
  use Ecto.Migration

  def change do
    create table("case", primary_key: :false) do
      add :id, :binary_id, primary_key: :true
      add :title, :string, size: 40
      add :description, :text
      add :status, :string, size: 50
      add :public, :boolean

      timestamps()
    end
  end
end
