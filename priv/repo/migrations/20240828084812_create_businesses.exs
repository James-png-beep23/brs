defmodule Brs.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :name, :string, null: false
      add :registration_number, :string, null: false
      add :status, :string, null: false, default: "active"
      add :registration_date, :date, null: false
      add :business_type_id, references(:business_types, on_delete: :nothing), null: false

      add :business_type_semantic_id,
          references(:business_types,
            column: :semantic_id,
            type: :string,
            on_update: :update_all,
            on_delete: :nothing
          ),
          null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:businesses, [:registration_number])
    create unique_index(:businesses, [:name])
    create index(:businesses, [:business_type_id])
  end
end
