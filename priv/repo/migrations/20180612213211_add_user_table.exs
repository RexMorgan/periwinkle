defmodule Periwinkle.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table("user", primary_key: :false) do
      add :id, :binary_id, primary_key: :true
      add :username, :string, size: 40
      add :password, :string, size: 70
      
      timestamps()
    end
  end
end
