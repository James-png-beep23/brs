defmodule Brs.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brs.Accounts.IDType

  schema "users" do
    field :id_number, :string
    belongs_to :id_type, IDType
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash
    field :phone_number
    field :first_name, :string
    field :last_name, :string
    field :surname, :string
    field :gender
    field :date_of_birth, :date
    field :otp_type, :string
    field :signature, :map
    field :nationality, :string, default: "KE"
    field :verified, :boolean, default: false
    field :enable_developer_settings, :boolean, default: false

    has_one :account, Brs.Accounts.Account
    has_many :backend_users, Brs.Accounts.BackendUser

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :id_number,
      :id_type_id,
      :email,
      :password,
      :phone_number,
      :first_name,
      :last_name,
      :surname,
      :gender,
      :date_of_birth,
      :verified,
      :otp_type,
      :nationality,
      :enable_developer_settings
    ])
    |> validate_required([:id_number, :id_type_id])
    |> update_change(:id_number, &String.trim/1)
    |> update_change(:id_number, &String.downcase/1)
    |> update_if_valid(:email, &String.trim/1)
    |> update_if_valid(:email, &String.downcase/1)
    |> foreign_key_constraint(:id_type, message: "Missing")
    |> unique_constraint(:phone_number)
    |> unique_constraint([:id_number, :id_type_id], name: :unique_id_number_id_type_id)
  end

  defp update_if_valid(changeset, field, fun) do
    if value = get_change(changeset, field) do
      put_change(changeset, field, fun.(value))
    else
      changeset
    end
  end
end
