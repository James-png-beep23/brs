defmodule BrsWeb.AnnouncementLive.Edit do
  use BrsWeb, :live_view

  @impl true
  def handle_params(%{"id" => _id}, _, socket) do
    {:noreply, socket}
  end
end
