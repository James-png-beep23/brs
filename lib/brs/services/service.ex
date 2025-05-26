defmodule Brs.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :name, :string
    field :prefix, :string
    field :published, :boolean, default: false
    field :application_counter, :integer

    belongs_to :form, Brs.Forms.Form
    belongs_to :registry, Brs.Registries.Registry

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :published, :form_id, :registry_id, :prefix, :application_counter])
    |> validate_required([:name, :published, :form_id, :registry_id, :prefix])
  end
end
