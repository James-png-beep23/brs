defmodule BrsWeb.ClientLive.Index do
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(initialize_tabs())
     |> assign(:clients, [])
     |> assign(:show_blacklist_modal, false)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("toggle_blacklist_modal", _, socket) do
    {:noreply,
     socket
     |> assign(show_blacklist_modal: !socket.assigns.show_blacklist_modal)}
  end

  defp apply_action(socket, :new, _params) do
    socket |> assign(:title, "Add Blacklist Client")
  end

  defp apply_action(socket, :index, _params) do
    socket |> assign(:title, "Blacklist Client")
  end

  defp initialize_tabs() do
    %{
      tabs: [
        %{
          id: 1,
          title: "Search clients",
          total_notifications: 0,
          mod: BrsWeb.ClientLive.Components.SearchClientComponent
        },
        %{
          id: 2,
          title: "Blacklisted clients",
          total_notifications: 4,
          mod: BrsWeb.ClientLive.Components.BlacklistedClientComponent
        }
      ],
      active_tab: 1
    }
  end

  # Handle the message from the component
  @impl true
  def handle_info({:switch_tab, index}, socket) do
    index = String.to_integer(index)

    {:noreply, assign(socket, :active_tab, index)}
  end

  def handle_info({:search_result, data}, socket) do
    {:noreply, socket |> assign(clients: data)}
  end
end
