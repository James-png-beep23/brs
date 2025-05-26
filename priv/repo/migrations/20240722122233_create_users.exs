defmodule Brs.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    create table(:users) do
      add :id_number, :citext, null: false
      add :id_type_id, references(:id_types, on_delete: :nothing)
      add :email, :string
      add :password_hash, :string
      add :phone_number, :string, size: 20
      add :first_name, :string
      add :last_name, :string
      add :surname, :string
      add :gender, :string
      add :date_of_birth, :date
      add :otp_type, :string
      add :signature, :map
      add :nationality, :string, null: false, default: "KE"
      add :verified, :boolean, null: false, default: false
      add :enable_developer_settings, :boolean, null: false, default: false

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:users, [:id_number, :id_type_id], name: :unique_id_number_id_type_id))
    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:phone_number]))
  end
end
