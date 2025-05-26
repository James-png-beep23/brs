defmodule Brs.Repo.Migrations.AddSearchIndexesToBusinesses do
  use Ecto.Migration

  def change do
    execute(
      "DROP INDEX if exists businesses_simple_trgm_idx",
      "CREATE INDEX businesses_simple_trgm_idx ON businesses USING GIN (to_tsvector('simple', name))"
    )

    execute(
      "DROP INDEX if exists businesses_english_trgm_idx",
      "CREATE INDEX businesses_english_trgm_idx ON businesses USING GIN (to_tsvector('english', name))"
    )
  end
end
