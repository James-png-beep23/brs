defmodule BrsWeb.CompanyLive.Tabs.CompanyDetailsComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end
end
