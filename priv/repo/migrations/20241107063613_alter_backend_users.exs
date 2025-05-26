defmodule Brs.Repo.Migrations.AlterBackendUsers do
  use Ecto.Migration

  def change do
    alter table(:backend_users) do
      add :department, :string, null: true
      add :office, :string, null: true
      add :designation, :string, null: true
      add :email_otp, :boolean, null: false, default: false
      add :sms_otp, :boolean, null: false, default: false
    end
  end
end
