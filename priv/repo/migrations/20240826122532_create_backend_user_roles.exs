defmodule Brs.Repo.Migrations.CreateBackendUserRoles do
  use Ecto.Migration

  def change do
    create table(:backend_user_roles) do
      add :role_id, references(:roles, on_delete: :delete_all)
      add :backend_user_id, references(:backend_users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:backend_user_roles, [:role_id])
    create index(:backend_user_roles, [:backend_user_id])
    create(unique_index(:backend_user_roles, [:role_id, :backend_user_id]))
  end
end
