defmodule Brs.Repo.Migrations.AlterBackendUsersRolesPermissionsRegistryScoping do
  use Ecto.Migration

  def change do
    alter table(:backend_users) do
      add :is_admin, :boolean, default: false, null: false
      add :is_default, :boolean, default: false, null: false

      add :registry_id, references(:registries, on_delete: :delete_all, on_update: :update_all),
        null: true
    end

    drop_if_exists(unique_index(:backend_users, [:user_id]))

    create(
      index(:backend_users, [:user_id, :registry_id],
        unique: true,
        nulls_distinct: false
      )
    )

    alter table(:roles) do
      add :registry_id, references(:registries, on_delete: :delete_all, on_update: :update_all),
        null: true
    end

    alter table(:permissions) do
      add :description, :string, null: true

      add :registry_id, references(:registries, on_delete: :delete_all, on_update: :update_all),
        null: true
    end

    create(
      index(:permissions, [:key, :registry_id],
        unique: true,
        nulls_distinct: false
      )
    )
  end
end
