defmodule BrsWeb.ServiceLive.Show do
  use BrsWeb, :live_view
  alias Brs.Services
  on_mount {BrsWeb.InitAssigns, :audit_log_user}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:service, Services.get_service!(id))}
  end
end
