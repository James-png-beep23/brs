defmodule Brs.Repo.Migrations.CreateStages do
  use Ecto.Migration

  def change do
    create table(:stages) do
      add :name, :string, null: false
      add :service_id, references(:services, on_delete: :delete_all), null: false
      add :semantic_id, :string, null: false

      timestamps(type: :utc_datetime)
    end

    # Create a unique index for (service_id, semantic_id)
    create unique_index(:stages, [:service_id, :semantic_id])
  end
end
