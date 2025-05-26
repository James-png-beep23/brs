defmodule Brs.Repo.Migrations.AlterUsersAddTrgmIndexes do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS pg_trgm")

    execute(
      "CREATE INDEX users_full_text_search_index ON users USING GIN (to_tsvector('simple', coalesce(first_name, ' ') || ' ' || coalesce(last_name, ' ') || ' ' || coalesce(surname, ' ')))"
    )

    create index(:users, [:id_number])
  end

  def down do
    execute("DROP INDEX IF EXISTS users_full_text_search_index")

    drop index(:users, [:id_number])
  end
end
