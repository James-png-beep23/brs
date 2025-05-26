defmodule Brs.Accounts.BackendUserRole do
  alias Brs.Accounts.{BackendUser, Role}
  use Ecto.Schema
  import Ecto.Changeset

  schema "backend_user_roles" do
    belongs_to :role, Role
    belongs_to :backend_user, BackendUser

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(backend_user_role, attrs) do
    backend_user_role
    |> cast(attrs, [:role_id, :backend_user_id])
    |> validate_required([:role_id, :backend_user_id])
    |> unique_constraint([:role_id, :backend_user_id])
  end
end
