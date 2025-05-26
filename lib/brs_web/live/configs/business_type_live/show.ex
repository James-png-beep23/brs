defmodule BrsWeb.Configs.BusinessTypeLive.Show do
  use BrsWeb, :live_view

  alias Brs.Businesses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    owner_types = Businesses.list_business_owner_types()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :business_type,
       Businesses.get_business_type(id)
       |> Businesses.preload_owner_types()
     )
     |> assign(:owner_types, owner_types)}
  end

  defp page_title(:show), do: "Show Business Type"
  defp page_title(:edit), do: "Edit Business Type"
end
