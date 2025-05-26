defmodule Brs.Repo.Migrations.CreateFormsTable do
  use Ecto.Migration

  def change do
    execute(
      "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"",
      ""
    )

    create table(:forms) do
      add(:name, :string, null: false)
      add(:uuid, :uuid, null: false, default: fragment("uuid_generate_v4()"))
      add(:schema, :map, null: true)

      timestamps()
    end

    create(unique_index(:forms, [:name, :uuid]))
  end
end
