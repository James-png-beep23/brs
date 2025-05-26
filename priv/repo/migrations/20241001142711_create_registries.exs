defmodule Brs.Repo.Migrations.CreateRegistries do
  use Ecto.Migration

  alias Brs.Registries.Registry

  @registries_params [
    %{
      "name" => "Businesses Registry",
      "slug" => "brs",
      "is_default" => true
    },
    %{
      "name" => "Hire Purchase Registry",
      "slug" => "hp"
    },
    %{
      "name" => "Trustee Registry",
      "slug" => "trustees"
    },
    %{
      "name" => "MPSR",
      "slug" => "mpsr"
    },
    %{
      "name" => "Official Receiver",
      "slug" => "or"
    }
  ]

  def change do
    create table(:registries) do
      add :name, :string, null: false
      add :slug, :string, null: false
      add :description, :string
      add :enabled, :boolean, default: true
      add :is_default, :boolean, default: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:registries, [:slug])

    execute(
      fn ->
        @registries_params
        |> Enum.map(fn reg ->
          %Registry{}
          |> Registry.changeset(reg)
          |> repo().insert!(
            on_conflict: :replace_all,
            conflict_target: [:slug]
          )
        end)
      end,
      ""
    )
  end
end
