defmodule BrsWeb.Forms.Pvt.FormComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok,
     assign(socket, assigns)
     |> assign(tabs: tab_init())
     |> assign(current_step: assigns[:current_step] || 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component
        module={BrsWeb.Forms.TabsComponent}
        id="form-tabs"
        tabs={@tabs}
        active_tab={@current_step}
      />

      <.live_component
        :for={tab <- @tabs}
        :if={@current_step == tab.id}
        id="form"
        module={tab.mod}
        form_data={@form_data}
        current_step={@current_step}
      />

      <div class="flex justify-start p-4 mt-2 space-x-4 border-t border-gray-200">
        <button
          phx-click="prev-step"
          phx-target={@myself}
          type="button"
          class="px-4 py-2 text-sm font-medium text-[#1E293B] border border-gray-300 rounded-md hover:bg-gray-100"
        >
          Previous
        </button>
        <button
          phx-click="next-step"
          phx-target={@myself}
          type="button"
          class="px-4 py-2 text-sm font-medium text-white !bg-[#1E293B] rounded-md hover:bg-[#1E293B]"
        >
          <%= if is_last_tab?(@current_step), do: "Complete", else: "Next" %>
        </button>
        <button
          type="button"
          class="btn btn-primary !bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 focus:ring-2 focus:ring-gray-400 hidden"
        >
          Preview
        </button>
      </div>
    </div>
    """
  end

  defp tab_init() do
    [
      %{
        id: 1,
        title: "Proposed Names",
        mod: BrsWeb.Forms.ProposedNamesComponent
      },
      %{
        id: 2,
        title: "Applicant Details",
        mod: BrsWeb.Forms.ApplicantDetailsComponent
      },
      %{
        id: 3,
        title: "Articles of Association",
        mod: BrsWeb.Forms.ArticlesOfAssociationComponent
      },
      %{
        id: 4,
        title: "Registered Office Address",
        mod: BrsWeb.Forms.OfficeAddressComponent
      },
      %{
        id: 5,
        title: "Share Information",
        mod: BrsWeb.Forms.ShareInfoComponent
      },
      %{
        id: 6,
        title: "Ownership Details",
        mod: BrsWeb.Forms.OwnershipDetailsComponent
      },
      %{
        id: 7,
        title: "Application Documents",
        mod: BrsWeb.Forms.DocumentsComponent
      },
      %{
        id: 8,
        title: "Declaration",
        mod: BrsWeb.Forms.DeclarationComponent
      }
    ]
  end

  @impl true
  def handle_event("next-step", _params, socket) do
    current_step = socket.assigns.current_step
    mod = get_mod_by_id(socket.assigns.tabs, current_step)

    send_update(mod,
      id: "form",
      form_action: :submit_form,
      current_step: current_step,
      submit: is_last_tab?(current_step)
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("prev-step", _params, socket) do
    active_tab = socket.assigns.current_step - 1
    send(self(), {:prev_step, active_tab})

    {:noreply, socket}
  end

  defp get_mod_by_id(tabs, id) do
    tabs
    |> Enum.find(&(&1.id == id))
    |> Map.get(:mod)
  end

  defp is_last_tab?(current_tab) do
    max_tab_id =
      tab_init()
      |> Enum.map(& &1.id)
      |> Enum.max()

    current_tab == max_tab_id
  end
end
