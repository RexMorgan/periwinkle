defmodule Periwinkle.Lists.ListValue do
  use Periwinkle.Schema
  import Ecto.Changeset

  schema "listvalue" do
    field(:list_name, :string, source: :listname)
    field(:value, :string, source: :keyname)
    field(:order, :integer, source: :displayorder)
    field(:active, :boolean)
    field(:is_default, :boolean, source: :isdefault)
    field(:integration_id, :string, source: :integrationid)
    field(:parent_id, :binary_id, source: :listvalue_id)
  end
end