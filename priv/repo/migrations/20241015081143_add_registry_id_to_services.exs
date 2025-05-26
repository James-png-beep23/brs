defmodule Brs.Repo.Migrations.AddRegistryIdToServices do
  use Ecto.Migration
  import Ecto.Query, only: [from: 2]

  def change do
    alter table(:services) do
      add :registry_id, references(:registries, on_delete: :delete_all)
    end

    execute(
      fn ->
        brs = repo().get_by!(Brs.Registries.Registry, slug: "brs")

        from(s in "services", where: is_nil(s.registry_id))
        |> repo().update_all(set: [registry_id: brs.id])
      end,
      ""
    )

    alter table(:services) do
      modify :registry_id, references(:registries, on_delete: :delete_all),
        null: false,
        from: {references(:registries, on_delete: :delete_all), null: true}
    end
  end
end
