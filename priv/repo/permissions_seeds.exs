defmodule Brs.PermissionsSeeder do
  alias Brs.Repo
  alias Brs.Accounts.Permission
  alias Brs.Registries.Registry

  def run(_env) do
    case File.read("priv/permissions.json") do
      {:ok, file_content} ->
        case Jason.decode(file_content) do
          {:ok, permissions} ->
            registries = Repo.all(Registry)

            permissions_list = build_permissions(permissions, registries)

            Repo.insert_all(Permission, permissions_list,
              on_conflict: :nothing,
              conflict_target: [:key, :registry_id]
            )

          {:error, decode_error} ->
            IO.puts("Error decoding JSON: #{decode_error}")
        end

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
    end
  end

  defp build_permissions(permissions, registries) do
    Enum.flat_map(
      permissions,
      fn %{"key" => key, "name" => name, "registries" => registry_slugs} = permission ->
        description = Map.get(permission, "description", nil)

        Enum.map(registry_slugs, fn registry_slug ->
          registry_id =
            case registry_slug do
              "system" ->
                nil

              _ ->
                case Enum.find(registries, fn r -> r.slug == registry_slug end) do
                  %Registry{id: id} -> id
                  _ -> nil
                end
            end

          %{
            key: "#{registry_slug}.#{key}",
            name: name,
            description: description,
            registry_id: registry_id,
            inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
            updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
          }
        end)
      end
    )
  end
end

Brs.PermissionsSeeder.run(Mix.env())
