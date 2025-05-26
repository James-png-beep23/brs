defmodule BrsWeb.DashboardLive.HirePurchaseComponent do
  use BrsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component
        module={BrsWeb.DashboardLive.CompaniesRegistryComponent}
        id="hire-purchase-dash"
      />
    </div>
    """
  end
end
