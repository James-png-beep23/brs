defmodule Brs.Accounts.BackendUser do
  use Ecto.Schema
  import Ecto.Changeset

  alias Brs.Accounts.BackendUserRole
  alias Brs.Accounts
  alias Accounts.User

  schema "backend_users" do
    field :status, :string
    field :is_admin, :boolean, default: false
    field :is_default, :boolean, default: false
    field :department, :string
    field :office, :string
    field :designation, :string
    field :email_otp, :boolean, default: false
    field :sms_otp, :boolean, default: false

    belongs_to :user, User
    belongs_to :registry, Brs.Registries.Registry

    has_many :backend_user_roles, Brs.Accounts.BackendUserRole,
      foreign_key: :backend_user_id,
      on_replace: :delete

    has_many :roles, through: [:backend_user_roles, :role]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(backend_user, attrs) do
    backend_user
    |> cast(attrs, [
      :status,
      :is_admin,
      :is_default,
      :user_id,
      :registry_id,
      :department,
      :office,
      :designation,
      :email_otp,
      :sms_otp
    ])
    |> validate_required([:user_id])
    |> unique_constraint([:user_id, :registry_id])
    |> cast_backend_user_roles(attrs)
  end

  defp cast_backend_user_roles(changeset, %{"backend_user_roles" => role_ids}) do
    roles =
      role_ids
      |> Enum.reject(&is_nil/1)
      |> Enum.map(&%{role_id: String.to_integer(&1)})

    put_assoc(changeset, :backend_user_roles, roles, with: &BackendUserRole.changeset/2)
  end

  defp cast_backend_user_roles(changeset, _), do: changeset
end
