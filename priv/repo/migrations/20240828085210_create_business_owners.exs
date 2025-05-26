defmodule Brs.Repo.Migrations.CreateBusinessOwners do
  use Ecto.Migration

  def change do
    create table(:business_owners) do
      add :first_name, :string, null: false
      add :last_name, :string, null: true
      add :other_names, :string, null: true
      add :id_number, :string, null: false
      add :id_type, :string, null: false
      add :status, :string, null: false, default: "active"

      add :business_id, references(:businesses, on_delete: :nothing), null: false

      add :business_owner_type_id, references(:business_owner_types, on_delete: :nothing),
        null: false

      add :business_owner_type_semantic_id,
          references(:business_owner_types,
            column: :semantic_id,
            type: :string,
            on_update: :update_all,
            on_delete: :nothing
          ),
          null: false

      timestamps(type: :utc_datetime)
    end
  end
end
