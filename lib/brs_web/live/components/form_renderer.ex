defmodule BrsWeb.Components.FormRenderer do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <!-- Progress Indicator -->
      <ul class="flex flex-wrap text-sm font-medium text-center text-gray-500 border-b border-gray-200 dark:border-gray-700 dark:text-gray-400">
        <%= for {page, index} <- Enum.with_index(@pages) do %>
          <li class="me-2">
            <a
              href="#"
              phx-value-step={index}
              aria-current="page"
              class={"inline-block p-4 #{if @current_step == index, do: "text-blue-600  border-blue-600", else: "hover:text-gray-600 hover:border-gray-300 border-transparent"}  border-b-2 rounded-t-lg dark:bg-gray-800 dark:text-blue-500"}
            >
              <%= page.title %>
            </a>
          </li>
        <% end %>
      </ul>

      <.form
        id="form_page"
        for={@form}
        phx-target={@myself}
        phx-change="validate-form"
        phx-submit={
          if @current_step == Enum.count(@pages) - 1,
            do: "make-application",
            else: "next_step"
        }
        as={:dynamic_form}
        class="w-full md:ml-0 max-w-sm mx-auto"
      >
        <%= for field <- @form_schema.fields do %>
          <div class="mb-5">
            <.brs_input
              field={@form[String.to_existing_atom(field.name)]}
              name={field.name}
              label={field.label}
              type={field.type}
              options={field.options}
            />
          </div>
        <% end %>
        <div class="flex justify-start space-x-4 p-4  mt-2">
          <%= if @current_step > 0 do %>
            <button
              type="button"
              phx-target={@myself}
              phx-click="prev_step"
              phx-value-step={@current_step}
              class="inline-flex items-center px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400"
            >
              Previous
            </button>
          <% end %>

          <%= if @current_step < Enum.count(@pages) - 1 do %>
            <button
              type="submit"
              class="ml-auto inline-flex items-center px-4 py-2 bg-primary text-white rounded-md hover:bg-primary-700"
            >
              Next
            </button>
          <% else %>
            <button
              type="submit"
              class="ml-auto inline-flex items-center px-4 py-2 bg-primary text-white rounded-md hover:bg-primary-700"
            >
              Submit
            </button>
          <% end %>
        </div>
      </.form>
    </div>
    """
  end

  # Handle "Next" button
  def handle_event("next_step", form_data, socket) do
    current_step = socket.assigns.current_step
    send(self(), {:save_draft, form_data})

    {:noreply,
     assign(socket, :form_data, form_data)
     |> assign(:current_step, current_step + 1)}
  end

  # Handle "Previous" button
  def handle_event("prev_step", _params, socket) do
    current_step = socket.assigns.current_step
    send(self(), {:prev_step, current_step - 1})

    {:noreply, assign(socket, :current_step, current_step - 1)}
  end

  @impl true
  def handle_event("validate-form", params, socket) do
    filtered_params =
      params
      |> Enum.filter(fn {key, _value} -> key != "_target" end)
      |> Enum.into(%{})

    atomized_params =
      Enum.reduce(filtered_params, %{}, fn {key, value}, acc ->
        Map.put(acc, String.to_existing_atom(key), value)
      end)

    changeset =
      Brs.Forms.change_schema_page(socket.assigns.form_schema, atomized_params)
      |> Ecto.Changeset.cast(atomized_params, Map.keys(atomized_params))
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  @impl true
  def handle_event("make-application", params, socket) do
    send(self(), {"make-application", params})
    {:noreply, socket}
  end
end
