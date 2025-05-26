defmodule Brs.Forms.Page do
  use Ecto.Schema

  import Ecto.Changeset

  alias Brs.Forms.Field

  @primary_key false
  embedded_schema do
    field(:title, :string)
    embeds_many(:fields, Field, on_replace: :delete)
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_embed(:fields)
  end
end
