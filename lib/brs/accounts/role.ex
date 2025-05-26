defmodule Brs.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    belongs_to :registry, Brs.Registries.Registry

    has_many :backend_user_roles, Brs.Accounts.BackendUserRole, foreign_key: :role_id
    has_many :backend_users, through: [:backend_user_roles, :backend_user]

    has_many :role_permissions, Brs.Accounts.RolePermission,
      foreign_key: :role_id,
      on_replace: :delete

    has_many :permissions, through: [:role_permissions, :permission]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :registry_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> put_role_permissions(attrs)
  end

  defp put_role_permissions(changeset, attrs) do
    role_permissions =
      Map.get(attrs, "role_permissions", [])
      |> Enum.map(fn permission ->
        %{permission_key: permission}
      end)

    put_assoc(changeset, :role_permissions, role_permissions,
      with: &Brs.Accounts.RolePermission.changeset/2
    )
  end
end
