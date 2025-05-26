defmodule BrsWeb.BusinessNameRegistrationLive.Index do
  use BrsWeb, :live_view

  @impl true
  # Define the initial state
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:active_tab, "proposed_names")
      |> assign(:tabs, tabs())

    {:ok, socket}
  end

  # Workflow tabs
  def tabs() do
    [
      %{
        name: "proposed_names",
        title: "Proposed Names",
        mod: BrsWeb.Forms.ProposedNamesComponent
      },
      %{
        name: "applicant_details",
        title: "Applicant Details",
        mod: BrsWeb.Forms.Shared.ApplicantDetailsComponent
      },
      %{
        name: "nature_of_business",
        title: "Nature Of Business",
        mod: BrsWeb.BusinessNameRegistrationLive.Tabs.NatureOfBusinessComponent
      },
      %{
        name: "registered_office_address",
        title: "Registered Office Address",
        mod: BrsWeb.Forms.Shared.RegisteredOfficeAddressComponent
      },
      %{
        name: "ownership_information",
        title: "Ownership Information",
        mod: BrsWeb.BusinessNameRegistrationLive.Tabs.OwnershipInformationComponent
      },
      %{
        name: "application_documents",
        title: "Application Documents",
        mod: BrsWeb.Forms.Shared.ApplicationDocumentsComponent
      },
      %{
        name: "declaration",
        title: "Declaration",
        mod: BrsWeb.BusinessNameRegistrationLive.Tabs.DeclarationComponent
      }
    ]
  end

  # Handle tab click events
  def handle_event("select_tab", %{"tab" => tab}, socket) do
    socket = assign(socket, :active_tab, tab)
    {:noreply, socket}
  end
end
