defmodule BrsWeb.CompanyLive.Index do
  alias Brs.Businesses
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :businesses, [])}
  end

  @impl true
  def handle_info({:search, params}, socket) do
    {:noreply, assign(socket, :businesses, Businesses.business_search(params))}
  end
end
