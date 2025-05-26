defmodule BrsWeb.ClientLive.Show do
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(init_tabs())}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    client = Brs.Accounts.get_account(id)

    {:noreply, socket |> assign(client: client)}
  end

  defp init_tabs() do
    %{
      tabs: [
        %{id: 1, title: "Applications history", mod: BrsWeb.ClientLive.ApplHistoryComponent},
        %{id: 2, title: "Businesses", mod: BrsWeb.ClientLive.BusinessComponent},
        %{id: 3, title: "Audit log", mod: BrsWeb.ClientLive.AuditLogComponent}
      ],
      active_tab: 1,
      mobile_active_tab: 1
    }
  end

  # Handle the message from the component
  @impl true
  def handle_info({:switch_tab, index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     assign(socket, :active_tab, index)
     |> assign(:mobile_active_tab, index)}
  end

  def handle_info({:search_result, data}, socket) do
    if is_list(data) and Enum.all?(data, &match?(%Brs.Applications.Application{}, &1)),
      do: send_update(BrsWeb.ClientLive.ApplHistoryComponent, id: "client-1", applications: data)

    {:noreply, socket |> assign(applications: data)}
  end
end
