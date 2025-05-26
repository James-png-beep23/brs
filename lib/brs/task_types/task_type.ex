defmodule Brs.TaskTypes.TaskType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task_types" do
    field :allow_corrections, :boolean, default: true
    field :auto_assignable, :boolean, default: true
    field :name, :string
    field :semantic_id, :string
    belongs_to :service, Brs.Services.Service

    has_many :actions, Brs.TaskTypes.Action
    has_many :roles, Brs.TaskTypes.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task_type, attrs) do
    task_type
    |> cast(attrs, [:name, :semantic_id, :allow_corrections, :auto_assignable, :service_id])
    |> validate_required([:name, :semantic_id, :service_id])
    |> validate_format(:semantic_id, ~r/^[a-z_]+$/,
      message: "Can only contain small letters and underscore (_)"
    )
    |> unique_constraint(
      [:semantic_id, :service_id],
      name: :task_types_semantic_id_service_id_index
    )
  end
end
