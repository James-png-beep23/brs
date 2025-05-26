defmodule Brs.Repo.Migrations.CreateTaskTypeActions do
  use Ecto.Migration

  def change do
    create table(:task_type_actions) do
      add :label, :string, null: false
      add :color, :string
      add :comment_sheet_id, references(:forms, on_delete: :delete_all)
      add :task_type_id, references(:task_types, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:task_type_actions, [:comment_sheet_id])
    create index(:task_type_actions, [:task_type_id])
    create unique_index(:task_type_actions, [:task_type_id, :label])
  end
end
