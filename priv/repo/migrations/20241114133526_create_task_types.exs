defmodule Brs.Repo.Migrations.CreateTaskTypes do
  use Ecto.Migration

  def change do
    create table(:task_types) do
      add :name, :string, null: false
      add :semantic_id, :string, null: false
      add :allow_corrections, :boolean, default: true, null: false
      add :auto_assignable, :boolean, default: true, null: false
      add :service_id, references(:services, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:task_types, [:service_id])
    create index(:task_types, [:semantic_id])
    create unique_index(:task_types, [:semantic_id, :service_id])
  end
end
