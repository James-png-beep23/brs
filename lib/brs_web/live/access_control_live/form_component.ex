defmodule BrsWeb.AccessControlLive.FormComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(assigns, socket) do
    type = Map.get(assigns, :type)
    role = Map.get(assigns, :role)
    permission = Map.get(assigns, :permission)

    edit_form = initialize_edit_form(type, role, permission)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(edit_form: edit_form)}
  end

  @impl true
  def handle_event("validate", %{"permission" => permission_params}, socket) do
    changeset = Brs.Accounts.change_permission(socket.assigns.permission, permission_params)
    {:noreply, assign(socket, edit_form: to_form(changeset, action: :validate))}
  end

  def handle_event("validate", %{"role" => role_params}, socket) do
    changeset = Brs.Accounts.change_role(socket.assigns.role, role_params)

    {:noreply, assign(socket, edit_form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"permission" => permission_params}, socket) do
    save_permission(socket, permission_params)
  end

  def handle_event("save", %{"role" => role_params}, socket) do
    save_role(socket, socket.assigns.action, role_params)
  end

  defp save_permission(socket, permission_params) do
    case Brs.Accounts.update_permission(socket.assigns.permission, permission_params) do
      {:ok, permission} ->
        updated_permission =
          permission
          |> Brs.Accounts.preload_roles()

        notify_parent({:saved_permission, updated_permission})

        {:noreply,
         socket
         |> assign(:permission, updated_permission)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, edit_form: to_form(changeset))}
    end
  end

  defp save_role(socket, :new, role_params) do
    role_params = Map.put_new(role_params, "registry_id", socket.assigns.current_registry.id)

    case Brs.Accounts.create_role(role_params) do
      {:ok, role} ->
        notify_parent({:saved_role, role})

        {:noreply,
         socket
         |> assign(:role, role)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, edit_form: to_form(changeset))}
    end
  end

  defp save_role(socket, :edit, role_params) do
    case Brs.Accounts.update_role(socket.assigns.role, role_params) do
      {:ok, role} ->
        updated_role =
          role
          |> Brs.Accounts.preload_permissions()

        notify_parent({:saved_role, updated_role})

        {:noreply,
         socket
         |> assign(:role, updated_role)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, edit_form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp initialize_edit_form(type, role, permission) do
    changeset =
      case type do
        "permissions" ->
          permission = permission || %Brs.Accounts.Permission{}
          Brs.Accounts.change_permission(permission)

        "roles" ->
          role = role || %Brs.Accounts.Role{}
          Brs.Accounts.change_role(role)
      end

    to_form(changeset)
  end

  defp permission_checked?(permission_key, edit_form) do
    role_permissions =
      case edit_form.params["role_permissions"] do
        nil ->
          if is_list(edit_form.data.role_permissions) do
            Enum.map(edit_form.data.role_permissions, & &1.permission_key)
          else
            []
          end

        permissions when is_list(permissions) ->
          permissions
      end

    permission_key in role_permissions
  end
end
