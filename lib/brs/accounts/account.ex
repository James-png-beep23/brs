defmodule Brs.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    belongs_to :user, Brs.Accounts.User
    belongs_to :business, Brs.Businesses.Business
    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:user_id, :business_id])
    |> check_constraint(:user_id, name: "user_id_or_business_id_not_null")
  end
end
