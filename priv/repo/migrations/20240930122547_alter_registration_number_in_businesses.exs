defmodule Brs.Repo.Migrations.AlterRegistrationNumberInBusinesses do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    alter table(:businesses) do
      modify(:registration_number, :citext)
    end
  end
end
