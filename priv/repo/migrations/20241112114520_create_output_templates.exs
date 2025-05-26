defmodule Brs.Repo.Migrations.CreateOutputTemplates do
  use Ecto.Migration

  def change do
    create table(:output_templates) do
      add :name, :string, null: false
      add :semantic_id, :string, null: false
      add :content, :text, null: false
      add :service_id, references(:services, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:output_templates, [:service_id])
    create index(:output_templates, [:semantic_id])
    create unique_index(:output_templates, [:semantic_id, :service_id])
  end
end
