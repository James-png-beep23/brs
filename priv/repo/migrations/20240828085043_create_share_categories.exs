defmodule Brs.Repo.Migrations.CreateShareCategories do
  use Ecto.Migration

  def change do
    create table(:share_categories) do
      add :name, :string, null: false
      add :number_of_shares, :integer, null: false, default: 0
      add :business_id, references(:businesses, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:share_categories, [:business_id])
  end
end
