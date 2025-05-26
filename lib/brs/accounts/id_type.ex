defmodule Brs.Accounts.IDType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "id_types" do
    field :label, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(id_type, attrs) do
    id_type
    |> cast(attrs, [:slug, :label])
    |> validate_required([:slug, :label])
    |> unique_constraint(:slug)
  end
end
