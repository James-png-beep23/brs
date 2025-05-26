defmodule BrsWeb.AdminApplicationLive.Index do
  use BrsWeb, :live_view
  alias Brs.Applications
  alias Brs.Repo

  def mount(_params, _session, socket) do
    applications = applications(socket.assigns.current_user)

    {:ok, assign(socket, applications: applications, search_query: "")}
  end

  def handle_info({:search_result, search_result}, socket) do
    {:noreply, assign(socket, :applications, search_result)}
  end

  def applications(current_user) do
    Applications.list_applications(current_user) |> Repo.preload(service: [:registry])
  end
end
