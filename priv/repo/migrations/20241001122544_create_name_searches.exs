defmodule Brs.Repo.Migrations.CreateNameSearches do
  use Ecto.Migration

  def change do
    create table(:name_searches) do
      add :name, :string
      add :short_name, :string
      add :status, :string, default: "reserved"
      add :expires_at, :naive_datetime, null: true
      add :business_type_id, references(:business_types, on_delete: :nothing)

      add :business_type_semantic_id,
          references(:business_types,
            column: :semantic_id,
            type: :string,
            on_update: :update_all,
            on_delete: :nothing
          ),
          null: false

      add :business_id, references(:businesses, on_delete: :nothing), null: true

      timestamps(type: :utc_datetime)
    end

    create index(:name_searches, [:business_type_id])
    create index(:name_searches, [:business_type_semantic_id])
    create index(:name_searches, [:business_id])

    # Create the extension
    execute("CREATE EXTENSION IF NOT EXISTS pg_trgm")

    execute("""
    CREATE INDEX name_searches_english_trgm_idx ON name_searches USING GIN (to_tsvector('english', name))
    """)

    execute("""
    CREATE INDEX name_searches_simple_trgm_idx ON name_searches USING GIN (to_tsvector('simple', name))
    """)
  end
end
