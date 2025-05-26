defmodule Brs.OutputTemplates.OutputTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "output_templates" do
    field :content, :string
    field :name, :string
    field :semantic_id, :string
    belongs_to :service, Brs.Services.Service

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(output_template, attrs) do
    output_template
    |> cast(attrs, [:name, :semantic_id, :content, :service_id])
    |> validate_required([:name, :semantic_id, :content, :service_id])
    |> validate_format(:semantic_id, ~r/^[a-z_]+$/,
      message: "Can only contain small letters and underscore (_)"
    )
    |> unique_constraint(
      [:semantic_id, :service_id],
      name: :output_templates_semantic_id_service_id_index
    )
  end
end
