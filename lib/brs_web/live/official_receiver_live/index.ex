defmodule BrsWeb.OfficialReceiverLive.Index do
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  defp apply_action(socket, :index, _params) do
    {:noreply, socket |> assign(:page_title, "Official Receiver")}
  end

  defp apply_action(socket, _uri, _params) do
    {:noreply, socket}
  end
end
