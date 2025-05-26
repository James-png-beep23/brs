defmodule Brs.Repo.Migrations.CreateIdTypes do
  use Ecto.Migration

  def change do
    create table(:id_types) do
      add :slug, :string, null: false
      add :label, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:id_types, [:slug])

    execute("""
    INSERT INTO id_types (slug, label, inserted_at, updated_at)
    VALUES
      ('citizen', 'Citizen', now(), now()),
      ('alien', 'Alien', now(), now()),
      ('visitor', 'Visitor', now(), now())
    """)
  end
end
