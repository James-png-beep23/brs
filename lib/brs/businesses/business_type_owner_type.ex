defmodule Brs.Businesses.BusinessTypeOwnerType do
  use Ecto.Schema

  import Ecto.Changeset

  alias Brs.Businesses.{BusinessType, BusinessOwnerType}

  schema "business_type_owner_types" do
    belongs_to :business_type, BusinessType
    belongs_to :owner_type, BusinessOwnerType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business_type_owner_type, attrs) do
    business_type_owner_type
    |> cast(attrs, [:business_type_id, :owner_type_id])
    |> validate_required([:business_type_id, :owner_type_id])
    |> unique_constraint([:business_type_id, :owner_type_id])
  end
end
