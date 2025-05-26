defmodule Brs.Businesses.NameSearch do
  alias Brs.Repo
  alias Brs.Businesses.{Business, BusinessType}
  use Ecto.Schema
  import Ecto.Changeset

  schema "name_searches" do
    field :name, :string
    field :short_name, :string
    field :status, :string, default: "reserved"
    field :expires_at, :naive_datetime
    field :business_type_semantic_id, :string

    belongs_to :business_type, BusinessType
    belongs_to :business, Business

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(name_search, attrs) do
    name_search
    |> cast(attrs, [
      :name,
      :short_name,
      :status,
      :expires_at,
      :business_type_semantic_id,
      :business_type_id,
      :business_id
    ])
    |> update_short_name()
    |> validate_required([
      :name,
      :short_name,
      :status,
      :business_type_semantic_id,
      :business_type_id
    ])
  end

  def preload_assoc(name_search) do
    Repo.preload(name_search, [:business_type, :business])
  end

  defp update_short_name(changeset) do
    name = get_field(changeset, :name)

    if name do
      short_name = name |> String.split() |> List.first() |> String.replace(~r/[,\.]/, "")
      put_change(changeset, :short_name, short_name)
    else
      changeset
    end
  end
end
