defmodule Brs.Forms.Schema do
  use Ecto.Schema

  import Ecto.Changeset

  alias Brs.Forms.Page

  @primary_key false
  embedded_schema do
    embeds_many(:pages, Page, on_replace: :delete)
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [])
    |> cast_embed(:pages)
  end
end
