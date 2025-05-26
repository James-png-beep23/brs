defmodule BrsWeb.Shared.ApplicationSearchComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:placeholder_text, "Enter Application Number to search")
     |> assign_form()}
  end

  @impl true
  def handle_event("validate_application_search_form", %{"form" => form_params}, socket) do
    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply, assign(socket, application_search_form: form)}
  end

  def handle_event("submit_application_search", %{"form" => form_params}, socket) do
    current_registry = socket.assigns.current_registry

    search_result =
      Brs.Applications.application_search_by_registry(current_registry.id, form_params["q"])

    send(self(), {:search_result, search_result})

    {:noreply,
     socket
     |> assign(:application_search_form, to_form(search_changeset(form_params), as: "form"))}
  end

  defp assign_form(socket) do
    changeset = search_changeset()

    assign(socket, :application_search_form, to_form(changeset, as: "form"))
  end

  defp search_changeset(params \\ %{}) do
    data_types = %{q: :string}

    {%{}, data_types}
    |> Ecto.Changeset.cast(params, Map.keys(data_types))
  end
end
