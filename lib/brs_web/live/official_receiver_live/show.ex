defmodule BrsWeb.OfficialReceiverLive.Show do
  alias Brs.Businesses
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, init_tabs())}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    business = Businesses.get(id)

    {:noreply, socket |> assign(business: business)}
  end

  # Handle the message from the component
  @impl true
  def handle_info({:switch_tab, index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     assign(socket, :active_tab, index)
     |> assign(:mobile_active_tab, index)}
  end

  defp init_tabs() do
    %{
      tabs: [
        %{
          id: 1,
          title: "Company Details",
          mod: BrsWeb.OfficialReceiverLive.CompanyDetailsComponent
        },
        %{
          id: 2,
          title: "Receivership Details",
          mod: BrsWeb.OfficialReceiverLive.ReceivershipDetailsComponent
        },
        %{
          id: 3,
          title: "Applications History",
          mod: BrsWeb.OfficialReceiverLive.ApplicationHistoryComponent
        }
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end
end
