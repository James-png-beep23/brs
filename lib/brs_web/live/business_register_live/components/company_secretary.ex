defmodule BrsWeb.BusinessRegisterLive.Components.CompanySecretary do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div></div>
    """
  end
end
