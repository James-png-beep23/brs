defmodule BrsWeb.ServiceLive.Index do
  use BrsWeb, :live_view
  alias Brs.Services.Service
  alias Brs.Services
  on_mount {BrsWeb.InitAssigns, :audit_log_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :services, Services.list_services())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:service, %Service{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:service, nil)
  end

  @impl true
  def handle_info({BrsWeb.ServiceLive.FormComponent, {:saved, service}}, socket) do
    {:noreply, stream_insert(socket, :services, service)}
  end
end
