defmodule Brs.Forms.Form do
  use Ecto.Schema

  import Ecto.Changeset

  alias Brs.Forms.{Schema}

  schema "forms" do
    field(:name)
    field(:uuid, Ecto.UUID, read_after_writes: true)
    field :type, :string
    embeds_one(:schema, Schema, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:name, :uuid, :type])
    |> validate_required([:name, :type])
    |> cast_embed(:schema)
  end
end
