defmodule BrsWeb.RegistryLive.Index do
  use BrsWeb, :live_view

  alias Brs.Registries
  alias Brs.Registries.Registry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :registries, Registries.list_registries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Registry")
    |> assign(:registry, Registries.get_registry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Registry")
    |> assign(:registry, %Registry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Registries")
    |> assign(:registry, nil)
  end

  @impl true
  def handle_info({BrsWeb.RegistryLive.FormComponent, {:saved, registry}}, socket) do
    updated_registries = [registry | socket.assigns.registries]

    {:noreply, assign(socket, :registries, updated_registries)}
  end
end
