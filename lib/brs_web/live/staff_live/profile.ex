defmodule BrsWeb.StaffLive.Profile do
  alias Brs.Accounts
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(tabs())}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :index, %{"id" => user_id}) do
    case Accounts.get_backend_user_by_user_id(user_id) do
      nil ->
        current_registry = socket.assigns.current_registry

        {:noreply,
         socket
         |> put_flash(:error, "Failed to load staff: #{user_id}")
         |> push_navigate(to: ~p"/admin/registries/#{current_registry.slug}/staffs")}

      staff ->
        {:noreply,
         socket
         |> assign(:staff, staff)}
    end
  end

  # Handle the message from the component
  @impl true
  def handle_info({:switch_tab, index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     assign(socket, :active_tab, index)
     |> assign(:mobile_active_tab, index)}
  end

  def handle_info({:change_page, page}, socket) do
    {:noreply, assign(socket, :page, page)}
  end

  defp tabs() do
    %{
      tabs: [
        %{id: 1, title: "Profile", mod: BrsWeb.StaffLive.ProfileComponent},
        %{id: 2, title: "Inbox Tasks", mod: BrsWeb.StaffLive.InboxTaskComponent},
        %{id: 3, title: "Completed tasks", mod: BrsWeb.StaffLive.CompletedTaskComponent},
        %{id: 4, title: "Audit log", mod: BrsWeb.StaffLive.AuditLogComponent}
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end
end
