defmodule Brs.Repo.Migrations.AddApplicationNumberToApplications do
  use Ecto.Migration

  def change do
    alter table(:applications) do
      add :application_number, :string, null: false
      add :status, :string, null: false, default: "draft"
    end

    create(unique_index(:applications, [:application_number]))
  end
end
