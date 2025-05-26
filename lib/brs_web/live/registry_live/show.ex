defmodule BrsWeb.RegistryLive.Show do
  use BrsWeb, :live_view

  alias Brs.Registries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:registry, Registries.get_registry!(id))}
  end

  defp page_title(:show), do: "Show Registry"
  defp page_title(:edit), do: "Edit Registry"
end
