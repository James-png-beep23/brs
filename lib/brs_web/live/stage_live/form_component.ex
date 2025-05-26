defmodule BrsWeb.StageLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.Stages

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <.header>
          <%= @title %>
          <%= @action %>
          <:actions>
          <div class="mt-16">
            <.link
              phx-click="back"
              phx-value-id={@service_id}
              class="text-sm font-semibold leading-6 text-zinc-900 hover:text-zinc-700"
            >
              <.icon name="hero-arrow-left-solid" class="w-3 h-3" /> Back to list
            </.link>
          </div>
        </:actions>
        </.header>
        <div class="mt-10 space-y-8 bg-white py-3 px-5">
          <.simple_form
            for={@form}
            id="stage-form"
            phx-target={@myself}
            phx-submit="save"
          >
            <.input field={@form[:name]} type="text" label="Name" />
            <.input field={@form[:semantic_id]} type="text" label="Semantic ID (slug)" />
            <:actions>
              <.button phx-disable-with="Saving...">Save Stages</.button>
            </:actions>
          </.simple_form>
        </div>
      </div>
    """
  end

  @impl true
  def update(%{stage: stage} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Stages.change_stage(stage))
     end)}
  end

  def handle_event("save", %{"stage" => stage_params}, socket) do
    save_stage(socket, socket.assigns.action, stage_params)
  end

  defp save_stage(socket, :edit, stage_params) do
    stage_params = stage_params
      |> Map.put("service_id", socket.assigns.service_id)

    case Stages.update_stage(socket.assigns.stage, stage_params) do
      {:ok, stage} ->
        notify_parent({:saved, stage})

        {:noreply,
         socket
         |> put_flash(:info, "Stage updated successfully")
         |> assign(:live_action, :index)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_stage(socket, :new, stage_params) do
    stage_params = stage_params
      |> Map.put("service_id", socket.assigns.service_id)

    case Stages.create_stage(stage_params) do
      {:ok, stage} ->
        notify_parent({:saved, stage})

        {:noreply,
         socket
         |> put_flash(:info, "Stage created successfully")
         |> assign(:live_action, :index)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
