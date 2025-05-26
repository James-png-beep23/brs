defmodule BrsWeb.AccessControlLive.Index do
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    current_registry = socket.assigns.current_registry

    roles = Brs.Registries.get_registry_roles(current_registry.id)
    permissions = Brs.Registries.get_registry_permissions(current_registry.id)
    current_registry_permissions = Brs.Registries.get_registry_permissions(current_registry.id)

    {:ok,
     socket
     |> assign(access_control_tabs())
     |> assign(show_modal: false)
     |> assign(roles: roles, permissions: permissions)
     |> assign(:current_registry_permissions, current_registry_permissions)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  defp access_control_tabs() do
    %{
      tabs: [
        %{id: 1, title: "Roles", active: true},
        %{id: 2, title: "Permissions", active: false}
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end

  @impl true
  def handle_event("change_tab", %{"index" => index}, socket) do
    index = String.to_integer(index)
    {:noreply, assign(socket, :active_tab, index) |> assign(:mobile_active_tab, index)}
  end

  def handle_event("toggle_modal", _, socket) do
    {:noreply,
     socket
     |> assign(show_modal: !socket.assigns.show_modal)}
  end

  @impl true
  def handle_info({BrsWeb.AccessControlLive.FormComponent, {:saved_role, role}}, socket) do
    updated_roles = [role | socket.assigns.roles]

    {:noreply,
     socket
     |> assign(roles: updated_roles, show_edit_modal: false)
     |> put_flash(:info, "Role created successfully")
     |> push_navigate(to: ~p"/admin/registries/#{socket.assigns.current_registry.slug}/security")}
  end
end
