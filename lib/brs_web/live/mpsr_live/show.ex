defmodule BrsWeb.MpsrLive.Show do
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
        %{id: 1, title: "Notices", mod: BrsWeb.MpsrLive.NoticesComponent},
        %{id: 2, title: "Searches", mod: BrsWeb.MpsrLive.SearchesComponent}
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end
end
