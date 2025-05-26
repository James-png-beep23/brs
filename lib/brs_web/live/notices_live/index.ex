defmodule BrsWeb.NoticesLive.Index do
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
