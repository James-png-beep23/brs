defmodule Brs.Registries.Registry do
  use Ecto.Schema

  import Ecto.Changeset

  schema "registries" do
    field :name, :string
    field :slug, :string
    field :enabled, :boolean, default: true
    field :is_default, :boolean, default: false
    field :description, :string

    has_many :permissions, Brs.Accounts.Permission

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(registry, attrs) do
    registry
    |> cast(attrs, [:name, :slug, :enabled, :is_default, :description])
    |> validate_required([:name])
    |> unique_constraint(:slug)
    |> restrict_default_registry_disable()
  end

  defp restrict_default_registry_disable(changeset) do
    if get_field(changeset, :is_default) do
      case get_change(changeset, :enabled, get_field(changeset, :enabled)) do
        false ->
          add_error(changeset, :enabled, "Cannot disable the default registry.")

        _ ->
          changeset
      end
    else
      changeset
    end
  end
end
