defmodule BrsWeb.AccessControlLive.Show do
  use BrsWeb, :live_view

  import Phoenix.HTML.Form

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_search_form()
     |> assign(show_edit_modal: false)}
  end

  @impl true
  def handle_params(%{"type" => type, "id" => id}, _, socket) do
    current_registry = socket.assigns.current_registry

    current_registry_permissions = Brs.Registries.get_registry_permissions(current_registry.id)

    {:noreply,
     socket
     |> assign(:type, type)
     |> assign(:current_registry_permissions, current_registry_permissions)
     |> assign_current_role_permission(type, id)}
  end

  defp assign_current_role_permission(socket, type, id) do
    {role, permission, backend_users} =
      case type do
        "roles" ->
          role =
            Brs.Accounts.get_role(id)
            |> Brs.Accounts.preload_permissions()
            |> Brs.Accounts.preload_backend_users()

          backend_users = role.backend_users

          {role, nil, backend_users}

        "permissions" ->
          permission =
            Brs.Accounts.get_permission(id)
            |> Brs.Accounts.preload_roles()

          backend_users =
            permission.roles
            |> Enum.flat_map(& &1.backend_users)
            |> Enum.uniq_by(& &1.id)

          {nil, permission, backend_users}
      end

    assign(socket,
      role: role,
      permission: permission,
      backend_users: backend_users
    )
  end

  @impl true
  def handle_event("toggle_edit_modal", _, socket) do
    {:noreply,
     socket
     |> assign(show_edit_modal: !socket.assigns.show_edit_modal)}
  end

  def handle_event("validate_backend_user_search_form", %{"form" => form_params}, socket) do
    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("perform_backend_user_search", %{"form" => query}, socket) do
    search_result =
      case socket.assigns.type do
        "roles" ->
          Brs.Accounts.role_backend_users_search_query(socket.assigns.role.id, query["q"])
          |> Brs.Repo.all()
          |> Brs.Repo.preload(user: :id_type)

        "permissions" ->
          Brs.Accounts.permission_backend_users_search_query(
            socket.assigns.permission.key,
            query["q"]
          )
          |> Brs.Repo.all()
          |> Brs.Repo.preload(user: :id_type)
      end

    {:noreply,
     socket
     |> assign(:form, to_form(search_changeset(query), as: "form"))
     |> assign(:backend_users, search_result)}
  end

  @impl true
  def handle_info({BrsWeb.AccessControlLive.FormComponent, {:saved_role, updated_role}}, socket) do
    {:noreply,
     socket
     |> assign(role: updated_role, show_edit_modal: false)
     |> put_flash(:info, "Role updated successfully")}
  end

  def handle_info(
        {BrsWeb.AccessControlLive.FormComponent, {:saved_permission, updated_permission}},
        socket
      ) do
    {:noreply,
     socket
     |> assign(permission: updated_permission, show_edit_modal: false)
     |> put_flash(:info, "Permission updated successfully")}
  end

  defp assign_search_form(socket) do
    changeset = search_changeset()

    assign(socket, :form, to_form(changeset, as: "form"))
  end

  defp search_changeset(params \\ %{}) do
    data_types = %{q: :string}

    {%{}, data_types}
    |> Ecto.Changeset.cast(params, Map.keys(data_types))
  end
end
