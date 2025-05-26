defmodule Brs.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:key, :string, autogenerate: false}
  schema "permissions" do
    field :name, :string
    field :description, :string
    belongs_to :registry, Brs.Registries.Registry

    has_many :role_permissions, Brs.Accounts.RolePermission, foreign_key: :permission_key
    has_many :roles, through: [:role_permissions, :role]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:key, :name, :description, :registry_id])
    |> validate_required([:key, :name])
    |> unique_constraint([:key, :registry_id])
  end
end
