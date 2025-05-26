defmodule BrsWeb.NameSearchLive.Index do
  alias Brs.Businesses
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :name_searches, [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Name Search")
  end

  @impl true
  def handle_info({:search, params}, socket) do
    {:noreply, assign(socket, :name_searches, Businesses.name_search(params))}
  end
end
