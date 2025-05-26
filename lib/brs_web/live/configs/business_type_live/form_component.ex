defmodule BrsWeb.Configs.BusinessTypeLive.FormComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  alias Brs.Businesses

  @impl true
  def update(%{business_type: business_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Businesses.change_business_type_and_owner_types(business_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"business_type" => business_type_params}, socket) do
    changeset =
      Businesses.change_business_type(
        socket.assigns.business_type,
        business_type_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"business_type" => business_type_params}, socket) do
    save_business_type(socket, socket.assigns.action, business_type_params)
  end

  defp save_business_type(socket, :edit, business_type_params) do
    case Businesses.update_business_type(
           socket.assigns.business_type,
           business_type_params
         ) do
      {:ok, business_type} ->
        notify_parent({:saved, business_type})

        {:noreply,
         socket
         |> put_flash(:info, "Business Type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_business_type(socket, :new, business_type_params) do
    case Businesses.create_business_type(business_type_params) do
      {:ok, business_type} ->
        notify_parent({:saved, business_type})

        {:noreply,
         socket
         |> put_flash(:info, "Business Type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp owner_type_checked?(owner_type_id, form) do
    business_type_owner_types =
      form.params["business_owner_type_ids"]
      |> case do
        nil -> form.data.business_owner_type_ids || []
        owner_types -> Enum.map(owner_types, &String.to_integer/1)
      end

    owner_type_id in business_type_owner_types
  end
end
