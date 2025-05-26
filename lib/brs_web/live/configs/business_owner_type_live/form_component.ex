defmodule BrsWeb.Configs.BusinessOwnerTypeLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.Businesses

  @impl true
  def update(%{business_owner_type: business_owner_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Businesses.change_business_owner_type(business_owner_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"business_owner_type" => business_owner_type_params}, socket) do
    changeset =
      Businesses.change_business_owner_type(
        socket.assigns.business_owner_type,
        business_owner_type_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"business_owner_type" => business_owner_type_params}, socket) do
    save_business_owner_type(socket, socket.assigns.action, business_owner_type_params)
  end

  defp save_business_owner_type(socket, :edit, business_owner_type_params) do
    case Businesses.update_business_owner_type(
           socket.assigns.business_owner_type,
           business_owner_type_params
         ) do
      {:ok, business_owner_type} ->
        notify_parent({:saved, business_owner_type})

        {:noreply,
         socket
         |> put_flash(:info, "Owner Type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_business_owner_type(socket, :new, business_owner_type_params) do
    case Businesses.create_business_owner_type(business_owner_type_params) do
      {:ok, business_owner_type} ->
        notify_parent({:saved, business_owner_type})

        {:noreply,
         socket
         |> put_flash(:info, "Owner Type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
