defmodule Brs.Repo.Migrations.CreateTaskTypeRoles do
  use Ecto.Migration

  def change do
    create table(:task_type_roles) do
      add :task_type_id, references(:task_types, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:task_type_roles, [:task_type_id])
    create index(:task_type_roles, [:role_id])
    create unique_index(:task_type_roles, [:task_type_id, :role_id])
  end
end
