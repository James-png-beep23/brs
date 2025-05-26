defmodule BrsWeb.ApplicationLive.Show do
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => application_id}, _, socket) do
    application =
      Brs.Applications.get_application!(application_id)
      |> Brs.Repo.preload(:form)

    {:noreply,
     socket
     |> assign(:current_tab, 0)
     |> assign(:application, application)}
  end

  @impl true
  def handle_event("switch_tab", %{"index" => index}, socket) do
    {:noreply, socket |> assign(:current_tab, String.to_integer(index))}
  end
end
