defmodule BrsWeb.StaffLive.Index do
  alias Brs.Accounts
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :staffs, [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def apply_action(socket, :index, _params) do
    current_registry_id = socket.assigns.current_registry.id

    socket
    |> assign(page_title: "List Staffs")
    |> assign(:staffs, list_staffs(current_registry_id))
  end

  defp list_staffs(registry_id) do
    Accounts.list_backend_users_by_registry(registry_id)
  end

  @impl true
  def handle_info({:search, params}, socket) do
    results =
      socket.assigns.current_registry.id
      |> Accounts.staff_search(params)

    {:noreply, assign(socket, :staffs, results)}
  end
end
