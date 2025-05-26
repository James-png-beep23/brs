defmodule BrsWeb.DashboardLive.MPSRComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component module={BrsWeb.DashboardLive.CompaniesRegistryComponent} id="mpsr-dash" />
    </div>
    """
  end
end
