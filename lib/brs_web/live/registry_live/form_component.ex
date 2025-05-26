defmodule BrsWeb.RegistryLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.Registries

  @impl true
  def update(%{registry: registry} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Registries.change_registry(registry))
     end)}
  end

  @impl true
  def handle_event("validate", %{"registry" => registry_params}, socket) do
    changeset = Registries.change_registry(socket.assigns.registry, registry_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"registry" => registry_params}, socket) do
    save_registry(socket, socket.assigns.action, registry_params)
  end

  defp save_registry(socket, :edit, registry_params) do
    case Registries.update_registry(socket.assigns.registry, registry_params) do
      {:ok, registry} ->
        notify_parent({:saved, registry})

        {:noreply,
         socket
         |> put_flash(:info, "Registry updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_registry(socket, :new, registry_params) do
    case Registries.create_registry(registry_params) do
      {:ok, registry} ->
        notify_parent({:saved, registry})

        {:noreply,
         socket
         |> put_flash(:info, "Registry created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
