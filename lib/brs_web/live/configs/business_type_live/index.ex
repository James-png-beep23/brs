defmodule BrsWeb.Configs.BusinessTypeLive.Index do
  use BrsWeb, :live_view

  alias Brs.Businesses
  alias Brs.Businesses.BusinessType

  @impl true
  def mount(_params, _session, socket) do
    owner_types = Businesses.list_business_owner_types()

    {:ok,
     socket
     |> assign(:business_types, Businesses.list_business_types())
     |> assign(:owner_types, owner_types)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Business Type")
    |> assign(:business_type, Businesses.get_business_type(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Business Type")
    |> assign(:business_type, %BusinessType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Business Types")
    |> assign(:business_type, nil)
  end

  @impl true
  def handle_info(
        {BrsWeb.Configs.BusinessTypeLive.FormComponent, {:saved, business_type}},
        socket
      ) do
    updated_business_types = [business_type | socket.assigns.business_types]

    {:noreply, assign(socket, :business_types, updated_business_types)}
  end
end
