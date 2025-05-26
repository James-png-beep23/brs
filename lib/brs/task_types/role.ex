defmodule Brs.TaskTypes.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task_type_roles" do
    belongs_to :task_type, Brs.TaskTypes.TaskType
    belongs_to :role, Brs.Accounts.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:task_type_id, :role_id])
    |> validate_required([:task_type_id, :role_id])
    |> unique_constraint([:task_type_id, :role_id],
      name: :task_type_roles_task_type_id_role_id_index,
      message: "Role has already been taken"
    )
  end
end
