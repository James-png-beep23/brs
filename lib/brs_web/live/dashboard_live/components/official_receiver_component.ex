defmodule BrsWeb.DashboardLive.OfficialReceiverComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component module={BrsWeb.DashboardLive.CompaniesRegistryComponent} id="or-receiver-dash" />
    </div>
    """
  end
end
