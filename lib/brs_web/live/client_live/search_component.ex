defmodule BrsWeb.ClientLive.SearchComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:placeholder_text, "Search name or ID Number")
     |> assign_form()}
  end

  @impl true
  def handle_event("validate_client_search_form", %{"form" => form_params}, socket) do
    placeholder = render_placeholder_text(form_params["id_type"])

    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply, assign(socket, client_search_form: form, placeholder_text: placeholder)}
  end

  def handle_event("submit_client_search", %{"form" => form_params}, socket) do
    search_result = Brs.Accounts.client_account_search(form_params["id_type"], form_params["q"])

    send(self(), {:search_result, search_result})

    {:noreply,
     socket
     |> assign(:client_search_form, to_form(search_changeset(form_params), as: "form"))}
  end

  defp assign_form(socket) do
    changeset = search_changeset()

    assign(socket, :client_search_form, to_form(changeset, as: "form"))
  end

  defp search_changeset(params \\ %{}) do
    data_types = %{q: :string, id_type: :string}

    {%{}, data_types}
    |> Ecto.Changeset.cast(params, Map.keys(data_types))
  end

  defp render_placeholder_text(id_type) do
    case id_type do
      "citizen" ->
        "Search name or ID Number"

      "alien" ->
        "Search name or Alien ID"

      "visitor" ->
        "Search name or Passport Number"

      "business" ->
        "Search name or Registration Number"
    end
  end
end
