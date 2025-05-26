defmodule BrsWeb.StaffLive.ProfileComponent do
  use BrsWeb, :live_component

  @impl true
  def update(%{staff: staff} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:assigned_roles, staff.roles)}
  end

  @impl true
  def handle_event("search_role", %{"search" => search_field}, socket) do
    assigned_roles =
      case socket.assigns[:staff].roles do
        nil ->
          []

        roles ->
          roles
          |> Enum.filter(fn role ->
            String.contains?(String.downcase(role.name), String.downcase(search_field))
          end)
      end

    {:noreply, socket |> assign(:assigned_roles, assigned_roles)}
  end
end
