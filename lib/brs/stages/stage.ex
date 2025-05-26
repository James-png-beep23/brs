defmodule Brs.Stages.Stage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stages" do
    field :name, :string
    field :semantic_id, :string
    belongs_to :service, Brs.Services.Service

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stage, attrs \\ %{}) do
    stage
    |> cast(attrs, [:name, :service_id, :semantic_id])
    |> validate_required([:name, :service_id, :semantic_id])
    |> validate_format(:semantic_id, ~r/^[a-z_]+$/, message: "must contain only lowercase letters and underscores")
    |> unique_constraint([:service_id, :semantic_id], name: :stages_system_id_semantic_id_index)
  end
end
