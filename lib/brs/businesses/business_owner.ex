defmodule Brs.Businesses.BusinessOwner do
  use Ecto.Schema
  import Ecto.Changeset

  alias Brs.Repo
  alias Brs.Businesses.{Business, BusinessOwnerType}

  schema "business_owners" do
    field :first_name, :string
    field :id_number, :string
    field :id_type, :string
    field :last_name, :string
    field :other_names, :string
    field :status, :string, default: "active"
    field :business_owner_type_semantic_id, :string

    belongs_to :business, Business
    belongs_to :business_owner_type, BusinessOwnerType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business_owner, attrs) do
    business_owner
    |> cast(attrs, [
      :first_name,
      :last_name,
      :other_names,
      :id_number,
      :id_type,
      :status,
      :business_id,
      :business_owner_type_id,
      :business_owner_type_semantic_id
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :other_names,
      :id_number,
      :id_type,
      :business_id
    ])
    |> validate_business_owner_type()
  end

  defp validate_business_owner_type(changeset) do
    business_owner_type_id = get_field(changeset, :business_owner_type_id)
    business_owner_type_semantic_id = get_field(changeset, :business_owner_type_semantic_id)

    cond do
      business_owner_type_id in ["", nil] and business_owner_type_semantic_id in ["", nil] ->
        add_error(
          changeset,
          :business_owner_type,
          "Either business_owner_type_id or business_owner_type_semantic_id must be provided"
        )

      is_integer(business_owner_type_id) ->
        case Repo.get(BusinessOwnerType, business_owner_type_id) do
          nil ->
            add_error(changeset, :business_owner_type_id, "Business owner type not found")

          business_owner_type ->
            put_change(
              changeset,
              :business_owner_type_semantic_id,
              business_owner_type.semantic_id
            )
        end

      is_binary(business_owner_type_semantic_id) ->
        case Repo.get_by(BusinessOwnerType, semantic_id: business_owner_type_semantic_id) do
          nil ->
            add_error(
              changeset,
              :business_owner_type_semantic_id,
              "Business owner type not found"
            )

          business_owner_type ->
            put_change(changeset, :business_owner_type_id, business_owner_type.id)
        end
    end
  end
end
