defmodule BrsWeb.DashboardLive.AllRegistries do
  use BrsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, init_tabs())
     |> assign(:page_title, "All Registries")}
  end

  def handle_info({:change_tab, index}, socket) do
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
          title: "Companies Registry",
          mod: BrsWeb.DashboardLive.CompaniesRegistryComponent,
          corrections: false
        },
        %{
          id: 2,
          title: "Official Receiver",
          mod: BrsWeb.DashboardLive.OfficialReceiverComponent,
          corrections: false
        },
        %{
          id: 3,
          title: "Collateral Registry (MPSR)",
          mod: BrsWeb.DashboardLive.MPSRComponent,
          corrections: false
        },
        %{
          id: 4,
          title: "Hire Purchase",
          mod: BrsWeb.DashboardLive.HirePurchaseComponent,
          corrections: false
        },
        %{
          id: 5,
          title: "Trust Registry",
          mod: BrsWeb.DashboardLive.TrustIncorporationComponent,
          corrections: false
        }
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end
end
