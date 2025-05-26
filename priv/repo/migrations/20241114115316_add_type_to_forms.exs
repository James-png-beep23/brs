defmodule Brs.Repo.Migrations.AddTypeToForms do
  use Ecto.Migration

  def change do
    alter table(:forms) do
      add :type, :string, null: false, default: "application"
    end
  end
end
