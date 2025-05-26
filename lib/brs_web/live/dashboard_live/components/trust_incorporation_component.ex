defmodule BrsWeb.DashboardLive.TrustIncorporationComponent do
  use BrsWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component
        module={BrsWeb.DashboardLive.CompaniesRegistryComponent}
        id="trust-incorporation-dash"
      />
    </div>
    """
  end

  @impl true
  def update(_assigns, socket) do
    {:ok, socket}
  end
end
