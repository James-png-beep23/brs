defmodule Brs.Repo.Migrations.CreateBusinessOwnerTypes do
  use Ecto.Migration

  def change do
    create table(:business_owner_types) do
      add :name, :string, null: false
      add :has_shareholding, :boolean, default: false, null: false
      add :semantic_id, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:business_owner_types, [:name])
    create unique_index(:business_owner_types, [:semantic_id])
  end
end
