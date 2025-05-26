defmodule Brs.Businesses.BusinessOwnerType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_owner_types" do
    field :name, :string
    field :semantic_id, :string
    field :has_shareholding, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business_owner_type, attrs) do
    business_owner_type
    |> cast(attrs, [:name, :semantic_id, :has_shareholding])
    |> validate_required([:name, :has_shareholding])
    |> validate_format(:semantic_id, ~r/^[a-z0-9_]+$/,
      message: "Only lowercase letters, numbers and underscore (_) can be used"
    )
    |> unique_constraint(:name)
    |> unique_constraint(:semantic_id)
  end
end
