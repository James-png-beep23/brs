defmodule BrsWeb.ServiceLive.FormComponent do
  alias Brs.Registries
  use BrsWeb, :live_component

  alias Brs.Services
  alias Brs.Forms.Form
  alias Brs.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form for={@form} id="service-form" phx-target={@myself} phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:prefix]} type="text" label="Prefix" />
        <.input
          type="select"
          field={@form[:published]}
          label="Published"
          options={[Yes: true, No: false]}
          class="form-control"
        />
        <.input
          field={@form[:form_id]}
          type="select"
          label="Choose your form"
          options={Enum.map(@forms, fn form -> {form.name, form.id} end)}
        />
        <.input
          field={@form[:registry_id]}
          type="select"
          label="Registry"
          options={Enum.map(@registries, fn registry -> {registry.name, registry.id} end)}
        />

        <:actions>
          <%= if @form_event == "save" do %>
            <.button phx-disable-with="Saving...">Save Service</.button>
          <% else %>
            <.button phx-disable-with="Updating...">Update Service</.button>
          <% end %>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{service: service} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Services.change_service(service))
     end)
     |> assign(:forms, Repo.all(Form))
     |> assign(:registries, Registries.list_enabled_registries())}
  end

  @impl true
  def handle_event("validate", %{"service" => service_params}, socket) do
    changeset = Services.change_service(socket.assigns.service, service_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"service" => service_params}, socket) do
    save_service(socket, socket.assigns.action, service_params)
  end

  defp save_service(socket, :new, service_params) do
    case Services.create_service(service_params) do
      {:ok, service} ->
        notify_parent({:saved, service})

        {:noreply,
         socket
         |> put_flash(:info, "Service created successfully")
         |> push_navigate(to: ~p"/system/services")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_service(socket, :edit, service_params) do
    case Services.update_service(socket.assigns.service, service_params) do
      {:ok, service} ->
        {:noreply,
         socket
         |> put_flash(:info, "Service updated successfully")
         |> push_patch(to: ~p"/system/services/#{service.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
