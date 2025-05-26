defmodule BrsWeb.Shared.SearchComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(prompt: Map.get(assigns, :prompt, "Search"))
     |> assign_form()}
  end

  @impl true
  def handle_event("validate_form", %{"form" => form_params}, socket) do
    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("perform_search", %{"form" => query}, socket) do
    send(self(), {:search, query})

    {:noreply,
     socket
     |> assign(:form, to_form(search_changeset(query), as: "form"))}
  end

  def handle_event("change_prompt", %{"form" => %{"filter_by" => prompt} = form_params}, socket) do
    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply,
     socket
     |> assign(:form, form)
     |> assign(prompt: "Search by #{humanize(prompt)}")}
  end

  defp assign_form(socket) do
    changeset = search_changeset()

    assign(socket, :form, to_form(changeset, as: "form"))
  end

  defp search_changeset(params \\ %{}) do
    data_types =
      case params["filter_by"] do
        nil ->
          params
          |> Enum.map(fn {key, _} -> {String.to_existing_atom(key), :string} end)
          |> Enum.into(%{q: :string})

        filter_by ->
          %{String.to_existing_atom(filter_by) => :string, q: :string}
      end

    {%{}, data_types}
    |> Ecto.Changeset.cast(params, Map.keys(data_types))
  end
end
