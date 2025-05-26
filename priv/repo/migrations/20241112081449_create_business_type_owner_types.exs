defmodule Brs.Repo.Migrations.CreateBusinessTypeOwnerTypes do
  use Ecto.Migration

  def change do
    create table(:business_type_owner_types) do
      add :business_type_id, references(:business_types, on_delete: :delete_all)
      add :owner_type_id, references(:business_owner_types, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:business_type_owner_types, [:business_type_id])
    create index(:business_type_owner_types, [:owner_type_id])
    create(unique_index(:business_type_owner_types, [:business_type_id, :owner_type_id]))
  end
end
