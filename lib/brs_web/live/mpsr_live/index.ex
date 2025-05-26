defmodule BrsWeb.MpsrLive.Index do
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "MPSR")}
  end
end
