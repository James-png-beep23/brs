defmodule Brs.Businesses.BusinessType do
  alias Brs.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_types" do
    field :name, :string
    field :semantic_id, :string
    field :has_shareholding, :boolean, default: false
    field :business_owner_type_ids, {:array, :integer}, virtual: true

    has_many :business_type_owner_types, Brs.Businesses.BusinessTypeOwnerType,
      foreign_key: :business_type_id,
      on_replace: :delete

    has_many :owner_types, through: [:business_type_owner_types, :owner_type]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business_type, attrs) do
    business_type
    |> cast(attrs, [:name, :semantic_id, :has_shareholding, :business_owner_type_ids])
    |> validate_required([:name, :has_shareholding])
    |> validate_format(:semantic_id, ~r/^[a-z0-9_]+$/,
      message: "Only lowercase letters, numbers and underscore (_) can be used"
    )
    |> unique_constraint(:name)
    |> unique_constraint(:semantic_id)
    |> put_business_type_owner_types()
  end

  def has_shareholding?(id) do
    case Repo.get(__MODULE__, id) do
      %__MODULE__{has_shareholding: has_shareholding} -> has_shareholding
      nil -> false
    end
  end

  defp put_business_type_owner_types(changeset) do
    business_owner_type_ids = get_field(changeset, :business_owner_type_ids) || []

    owner_types =
      business_owner_type_ids
      |> Enum.map(&%Brs.Businesses.BusinessTypeOwnerType{owner_type_id: &1})

    put_assoc(changeset, :business_type_owner_types, owner_types)
  end
end
