defmodule Brs.AuditLog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "audit_logs" do
    field :action, :string
    field :changes, :map
    field :record_id, :integer
    field :resource, :string
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:action, :resource, :record_id, :changes, :user_id])
    |> validate_required([:action, :resource, :record_id, :user_id])
  end
end
