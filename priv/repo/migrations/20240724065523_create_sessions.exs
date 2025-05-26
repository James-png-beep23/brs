defmodule Brs.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :session_id, :string, primary_key: true
      add :client_ip, :string
      add :user_agent, :string
      add :expires_at, :utc_datetime
      add :active, :boolean, default: true, null: false
      add :real_user_id, references(:users, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:sessions, [:session_id], where: "active = true"))
  end
end
