defmodule Brs.Repo.Migrations.AddPrefixToServices do
  use Ecto.Migration

  def change do
    alter table(:services) do
      add :prefix, :string, null: false, size: 10
      add :application_counter, :integer, null: false, default: 0
    end
  end
end
