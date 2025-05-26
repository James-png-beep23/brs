defmodule BrsWeb.TaskLive.TaskSearchComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign(show_filters_modal: false)}
  end

  @impl true
  def handle_event("toggle_filters_modal", _, socket) do
    {:noreply,
     socket
     |> assign(show_filters_modal: !socket.assigns.show_filters_modal)}
  end
end
