defmodule BrsWeb.Configs.BusinessOwnerTypeLive.Index do
  use BrsWeb, :live_view

  alias Brs.Businesses
  alias Brs.Businesses.BusinessOwnerType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :business_owner_types, Businesses.list_business_owner_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Owner Type")
    |> assign(:business_owner_type, Businesses.get_business_owner_type(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Owner Type")
    |> assign(:business_owner_type, %BusinessOwnerType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Owner Types")
    |> assign(:business_owner_type, nil)
  end

  @impl true
  def handle_info(
        {BrsWeb.Configs.BusinessOwnerTypeLive.FormComponent, {:saved, business_owner_type}},
        socket
      ) do
    updated_business_owner_types = [business_owner_type | socket.assigns.business_owner_types]

    {:noreply, assign(socket, :business_owner_types, updated_business_owner_types)}
  end
end
