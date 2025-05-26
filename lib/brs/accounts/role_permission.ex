defmodule Brs.Accounts.RolePermission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brs.Accounts.{Role, Permission}

  schema "role_permissions" do
    belongs_to :role, Role

    belongs_to :permission, Permission,
      references: :key,
      foreign_key: :permission_key,
      type: :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role_permission, attrs) do
    role_permission
    |> cast(attrs, [:role_id, :permission_key])
    |> validate_required([:role_id, :permission_key])
    |> unique_constraint([:role_id, :permission_key])
  end
end
