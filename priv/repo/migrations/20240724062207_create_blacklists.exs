defmodule Brs.Repo.Migrations.CreateBlacklists do
  use Ecto.Migration

  def change do
    create table(:blacklists) do
      add :reason, :string
      add :active, :boolean, default: true, null: false
      add :blacklisted_by_id, references(:users, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    # constrain self blacklisting
    create(
      constraint(:blacklists, :user_id_must_be_not_same_as_blacklisted_by_id,
        check: "user_id <> blacklisted_by_id"
      )
    )

    create_if_not_exists(
      unique_index(:blacklists, [:user_id, :blacklisted_by_id], where: "active = true")
    )
  end
end
