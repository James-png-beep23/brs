defmodule BrsWeb.TrustIncorporationLive.Show do
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, init_tabs())}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    business = Brs.Businesses.get(id)

    {:noreply, socket |> assign(business: business)}
  end

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
        %{id: 1, title: "Company Details", mod: BrsWeb.CompanyLive.Tabs.CompanyDetailsComponent},
        %{id: 2, title: "Documents", mod: BrsWeb.CompanyLive.Tabs.DocumentsComponent},
        %{id: 3, title: "Annual Returns", mod: BrsWeb.CompanyLive.Tabs.AnnualReturnsComponent},
        %{
          id: 4,
          title: "Applications History",
          mod: BrsWeb.CompanyLive.Tabs.ApplicationsHistoryComponent
        },
        %{id: 5, title: "Audit Trail", mod: BrsWeb.CompanyLive.Tabs.AuditTrailComponent},
        %{id: 6, title: "Access Control", mod: BrsWeb.CompanyLive.Tabs.AccessControlComponent},
        %{id: 7, title: "Businesses", mod: BrsWeb.CompanyLive.Tabs.BusinessesComponent}
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end
end
