defmodule BrsWeb.OutputTemplateLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.OutputTemplates

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage output template records.</:subtitle>
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
      <div class="bg-white px-4 py-1.5 ">
        <.simple_form
          for={@form}
          id="output_template-form"
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >
          <.input field={@form[:name]} type="text" label="Name" />
          <.input field={@form[:semantic_id]} type="text" label="Semantic Id" />
          <.input field={@form[:content]} type="textarea" label="Content" />
          <:actions>
            <.button phx-disable-with="Saving...">Save</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  @impl true
  def update(%{output_template: output_template} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(OutputTemplates.change_output_template(output_template))
     end)}
  end

  @impl true
  def handle_event("validate", %{"output_template" => output_template_params}, socket) do
    changeset =
      OutputTemplates.change_output_template(
        socket.assigns.output_template,
        output_template_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"output_template" => output_template_params}, socket) do
    output_template_params =
      Map.put(output_template_params, "service_id", socket.assigns.service_id)

    save_output_template(socket, socket.assigns.action, output_template_params)
  end

  defp save_output_template(socket, :edit, output_template_params) do
    case OutputTemplates.update_output_template(
           socket.assigns.output_template,
           output_template_params
         ) do
      {:ok, _output_template} ->
        notify_parent({:saved, "Output template updated successfully"})

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_output_template(socket, :new, output_template_params) do
    case OutputTemplates.create_output_template(output_template_params) do
      {:ok, _output_template} ->
        notify_parent({:saved, "Output template created successfully"})

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
