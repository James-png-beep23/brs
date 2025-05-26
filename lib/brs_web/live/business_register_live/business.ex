defmodule BrsWeb.BusinessRegisterLive.Business do
  use BrsWeb, :live_view
  @impl true

  def mount(params, _session, socket) do

    {:ok,
     socket
     |> assign(
       :current_registry,
       fetch_current_registry(socket.assigns.all_registries, params["slug"])
     )}
  end

  @impl true

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :services, %{"slug" => slug}) do

    socket
    |> assign(:page_title, "#{String.capitalize(slug)} Dashboard")
    |> assign(:mod, BrsWeb.BusinessRegisterLive.Components.Dashboard)
  end

  defp apply_action(socket, _, _params) do
    socket |> assign(:mod, BrsWeb.BusinessRegisterLive.Components.Dashboard)
  end

  defp fetch_current_registry(all_registries, slug) do
    Enum.find(all_registries, fn registry -> registry.slug == slug end)
  end
end
