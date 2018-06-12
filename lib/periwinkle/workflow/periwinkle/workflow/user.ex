defmodule Periwinkle.Workflow.User do
  @moduledoc false
  use Periwinkle.Schema

  schema "user" do
    field :username, :string
    field :password, Comeonin.Ecto.Password
    timestamps
  end
end
