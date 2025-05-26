defmodule Brs.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  alias Brs.Repo
  alias Brs.Businesses.{BusinessType, BusinessOwner, ShareCategory}

  schema "businesses" do
    field :name, :string
    field :registration_date, :date
    field :registration_number, :string
    field :status, :string, default: "active"
    field :business_type_semantic_id, :string

    belongs_to :business_type, BusinessType
    has_many :share_categories, ShareCategory
    has_many :owners, BusinessOwner
    has_one :account, Brs.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [
      :name,
      :registration_number,
      :status,
      :registration_date,
      :business_type_id,
      :business_type_semantic_id
    ])
    |> validate_required([
      :name,
      :registration_number,
      :registration_date
    ])
    |> validate_business_type()
    |> unique_constraint(:registration_number)
    |> unique_constraint(:name)
  end

  defp validate_business_type(changeset) do
    business_type_id = get_field(changeset, :business_type_id)
    business_type_semantic_id = get_field(changeset, :business_type_semantic_id)

    cond do
      is_nil(business_type_id) and is_nil(business_type_semantic_id) ->
        add_error(
          changeset,
          :business_type,
          "Either business_type_id or business_type_semantic_id must be provided"
        )

      is_nil(business_type_semantic_id) ->
        case Repo.get(BusinessType, business_type_id) do
          nil ->
            add_error(changeset, :business_type_id, "Business type not found")

          business_type ->
            put_change(changeset, :business_type_semantic_id, business_type.semantic_id)
        end

      is_nil(business_type_id) ->
        case Repo.get_by(BusinessType, semantic_id: business_type_semantic_id) do
          nil -> add_error(changeset, :business_type_semantic_id, "Business type not found")
          business_type -> put_change(changeset, :business_type_id, business_type.id)
        end
    end
  end
end
