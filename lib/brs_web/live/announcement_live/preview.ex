defmodule BrsWeb.AnnouncementLive.Preview do
  use BrsWeb, :live_view

  @impl true
  def handle_params(%{"id" => _id}, _, socket) do
    {:noreply, socket |> initialize_preview_tabs()}
  end

  @impl true
  def handle_event("switch_tab", %{"id" => id}, socket) do
    id = String.to_integer(id)

    {:noreply,
     socket
     |> assign(active_tab: id)}
  end

  defp initialize_preview_tabs(socket) do
    tabs = [
      %{id: 1, title: "Frontend Preview", active: true},
      %{id: 2, title: "Backend Preview", active: false}
    ]

    assign(socket, tabs: tabs, active_tab: 1)
  end
end
