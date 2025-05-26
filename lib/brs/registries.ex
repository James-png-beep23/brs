defmodule Brs.Registries do
  import Ecto.Query, only: [from: 2]

  alias Brs.Repo
  alias Brs.Registries.Registry
  alias Brs.Accounts.Permission
  alias Brs.Accounts.Role

  def change_registry(%Registry{} = registry, attrs \\ %{}) do
    Registry.changeset(registry, attrs)
  end

  def get_registry!(id), do: Repo.get!(Registry, id)

  def get_registry_by(fields), do: Repo.get_by(Registry, fields)

  def get_default_registry(), do: Repo.get_by(Registry, is_default: true)

  def list_registries() do
    Repo.all(Registry)
  end

  def list_enabled_registries() do
    Repo.all(from r in Registry, where: r.enabled == true)
  end

  def create_registry(attrs \\ %{}) do
    %Registry{}
    |> Registry.changeset(attrs)
    |> Repo.insert()
  end

  def update_registry(%Registry{} = registry, attrs) do
    registry
    |> Registry.changeset(attrs)
    |> Repo.update()
  end

  def delete_registry(registry) do
    Repo.delete(registry)
  end

  def get_registry_roles(registry_id) do
    Repo.all(from r in Role, where: r.registry_id == ^registry_id)
  end

  def get_registry_permissions(registry_id) do
    Repo.all(from r in Permission, where: r.registry_id == ^registry_id)
  end
end
