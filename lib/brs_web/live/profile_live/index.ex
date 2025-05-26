defmodule BrsWeb.ProfileLive.Index do
  use BrsWeb, :live_view

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    socket = socket |> assign(:current_user, current_user)
    {:ok, socket}
  end
end
