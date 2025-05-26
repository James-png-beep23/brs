defmodule Brs.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :account_id, references(:accounts, on_delete: :nothing, on_update: :update_all),
        null: false

      add :created_by_id, references(:users, on_delete: :nothing, on_update: :update_all),
        null: false

      add :submitted_by_id, references(:users, on_delete: :nothing, on_update: :update_all),
        null: false

      add :submitted_at, :naive_datetime

      add :service_id, references(:services, on_delete: :nothing, on_update: :update_all),
        null: false

      add :form_id, references(:forms, on_delete: :nothing, on_update: :update_all), null: false
      add :form_data, :jsonb, null: true

      timestamps()
    end

    create index(:applications, [:account_id])
    create index(:applications, [:created_by_id])
    create index(:applications, [:submitted_by_id])
    create index(:applications, [:service_id])
    create index(:applications, [:form_id])
  end
end
