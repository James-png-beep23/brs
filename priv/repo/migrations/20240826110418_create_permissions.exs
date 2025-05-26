defmodule Brs.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions, primary_key: false) do
      add :key, :string, primary_key: true, null: false
      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:permissions, [:key]))
  end
end
