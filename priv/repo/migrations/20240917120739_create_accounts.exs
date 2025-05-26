defmodule Brs.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_id, references(:users, on_delete: :delete_all, on_update: :update_all)
      add :business_id, references(:businesses, on_delete: :delete_all, on_update: :update_all)
      timestamps()
    end

    create unique_index(:accounts, [:user_id])
    create unique_index(:accounts, [:business_id])

    # Constraint check to ensure only either user_id or business_id is present
    create constraint("accounts", :user_id_or_business_id_not_null,
             check:
               "(user_id IS NOT NULL AND business_id IS NULL) OR (user_id IS NULL AND business_id IS NOT NULL)"
           )
  end
end
