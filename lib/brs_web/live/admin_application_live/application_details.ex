defmodule BrsWeb.AdminApplicationLive.ApplicationDetails do
  use BrsWeb, :live_component
  def mount(socket) do
    {:ok, socket}
  end
  # Handle events for changing tabs
  def handle_event("change_tab", %{"index" => index}, socket) do
    {:noreply, assign(socket, :active_tab, index) |> assign(:mobile_active_tab, index)}
  end
end
