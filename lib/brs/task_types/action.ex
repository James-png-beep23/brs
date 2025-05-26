defmodule Brs.TaskTypes.Action do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task_type_actions" do
    field :color, :string
    field :label, :string
    belongs_to :comment_sheet, Brs.Forms.Form
    belongs_to :task_type, Brs.TaskTypes.TaskType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:label, :color, :task_type_id, :comment_sheet_id])
    |> validate_required([:label, :task_type_id])
    |> unique_constraint(
      [:label, :task_type_id],
      name: :task_type_actions_task_type_id_label_index
    )
  end
end
