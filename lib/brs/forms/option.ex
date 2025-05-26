defmodule Brs.Forms.Option do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:label, :string)
    field(:value, :string)
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :label,
      :value
    ])
    |> validate_required([:label, :value])
  end
end
