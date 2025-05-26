defmodule BrsWeb.WorkflowLive.Index do
  use BrsWeb, :live_view

  @impl true
  # Define the initial state
  def mount(params, _session, socket) do
    socket =
      socket
      |> assign(:active_tab, "stages")
      |> assign(:tabs, tabs())
      |> assign(:service_id, params["id"])

    {:ok, socket}
  end

  # Workflow tabs
  def tabs() do
    [
      %{name: "stages", title: "Stages", mod: BrsWeb.StageLive.Index},
      %{
        name: "operations",
        title: "Operations",
        mod: nil
      },
      %{
        name: "task_types",
        title: "Task Types",
        mod: BrsWeb.TaskTypeLive.Index
      },
      %{
        name: "templates",
        title: "Templates",
        mod: BrsWeb.OutputTemplateLive.Index
      }
    ]
  end

  # Handle tab click events
  def handle_event("select_tab", %{"tab" => tab}, socket) do
    socket = assign(socket, :active_tab, tab)
    {:noreply, socket}
  end
end
