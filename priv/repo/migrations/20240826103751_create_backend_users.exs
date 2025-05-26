defmodule Brs.Repo.Migrations.CreateBackendUsers do
  use Ecto.Migration

  def change do
    create table(:backend_users) do
      add :status, :string, default: "active"
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:backend_users, [:user_id])
  end
end
