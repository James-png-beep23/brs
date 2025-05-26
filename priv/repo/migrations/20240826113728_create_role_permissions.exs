defmodule Brs.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all)

      add :permission_key,
          references(:permissions, on_delete: :delete_all, column: :key, type: :string)

      timestamps(type: :utc_datetime)
    end

    create index(:role_permissions, [:role_id])
    create index(:role_permissions, [:permission_key])
    create(unique_index(:role_permissions, [:role_id, :permission_key]))
  end
end
