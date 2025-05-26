defimpl Brs.Policies.Can, for: Brs.Accounts.BackendUser do
  alias Brs.Accounts.BackendUser
  alias Brs.Accounts.Role

  def can?(%BackendUser{is_admin: true}, _, _), do: true

  def can?(%BackendUser{} = backend_user, :manage, %Role{}),
    do: has_permission?(backend_user, "roles.manage")

  def can?(_actor, _action, _resource), do: false

  defp has_permission?(%BackendUser{registry: registry, roles: roles}, permission) do
    case roles do
      [] ->
        false

      _ ->
        Enum.any?(roles, fn role ->
          Enum.any?(role.permissions, fn perm ->
            perm.key == "#{registry.slug}.#{permission}"
          end)
        end)
    end
  end
end
