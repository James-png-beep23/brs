defmodule Brs.Repo.Migrations.CreateBusinessTypes do
  use Ecto.Migration

  def change do
    create table(:business_types) do
      add :name, :string, null: false
      add :has_shareholding, :boolean, default: false, null: false
      add :semantic_id, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:business_types, [:name])
    create unique_index(:business_types, [:semantic_id])
  end
end
