defmodule Brs.Businesses.ShareCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "share_categories" do
    field :name, :string
    field :number_of_shares, :integer
    belongs_to :business, Brs.Businesses.Business

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(share_category, attrs) do
    share_category
    |> cast(attrs, [:name, :number_of_shares, :business_id])
    |> validate_required([:name, :number_of_shares, :business_id])
  end
end
