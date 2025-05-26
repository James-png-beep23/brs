defmodule Brs.Repo.Migrations.CreateAuditLogs do
  use Ecto.Migration

  def change do
    create table(:audit_logs, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :action, :string, null: false
      add :resource, :string, null: false
      add :record_id, :integer, null: false
      add :changes, :map, null: false
      add :user_id, :integer, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:audit_logs, [:resource])
    create index(:audit_logs, [:record_id])
    create index(:audit_logs, [:user_id])
  end
end
