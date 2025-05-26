defmodule BrsWeb.AdminApplicationLive.Show do
  use BrsWeb, :live_view
  alias Brs.Applications
  alias Brs.Repo

  @impl true
  def mount(%{"id" => id}, _session, socket) do

    application = Applications.get_application!(id)
          |> Repo.preload(service: [:form])
          |> Repo.preload(created_by: [:id_type])

    active_tab = assign_application_default_active_tab(application)

    {:ok,
      socket
      |> assign(tabs())
      |> assign(application: application)
      |> assign(active_tab: active_tab)
    }
  end

  defp tabs() do
    %{
      tabs: [
        %{id: 1, title: "Comments", mod: BrsWeb.AdminApplicationLive.CommentsComponent},
        %{id: 2, title: "Commands", mod: BrsWeb.AdminApplicationLive.ComandsComponent},
        %{id: 3, title: "Stages", mod: BrsWeb.AdminApplicationLive.StagesComponent},
        %{id: 4, title: "Ledger", mod: BrsWeb.AdminApplicationLive.LedgerComponent},
        %{id: 5, title: "Corrections", mod: BrsWeb.AdminApplicationLive.CorrectionsComponent},
        %{id: 6, title: "Transfers", mod: BrsWeb.AdminApplicationLive.TransfersComponent},
        %{id: 7, title: "Audit Trail", mod: BrsWeb.AdminApplicationLive.AuditTrailComponent},
        %{id: 8, title: "Callbacks", mod: BrsWeb.AdminApplicationLive.CallbacksComponent}
      ],
      active_app_tab: 1,
      mobile_active_app_tab: 1
    }
  end

  # Handle the message from the component
  @impl true
  def handle_info({:switch_tab, index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     assign(socket, :active_app_tab, index)
     |> assign(:mobile_active_app_tab, index)}
  end

  def assign_application_default_active_tab(application) do
    application_pages = application.service.form.schema.pages
    if is_list(application_pages) do
      hd(application_pages).title
    else
      nil
    end
  end
end
