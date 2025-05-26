defmodule Brs.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :published, :boolean, default: false, null: false
      add :form_id, references(:forms, on_delete: :nothing), null: true

      timestamps(type: :utc_datetime)
    end

    create index(:services, [:form_id])
  end
end
