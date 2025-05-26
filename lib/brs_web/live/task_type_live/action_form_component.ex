defmodule BrsWeb.TaskTypeLive.ActionFormComponent do
  alias Brs.Forms
  use BrsWeb, :live_component

  alias Brs.TaskTypes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div
        id="test-modal"
        class="relative z-10"
        aria-labelledby="modal-title"
        role="dialog"
        aria-modal="true"
      >
        <div class="fixed inset-0 bg-gray-500/75 transition-opacity" aria-hidden="true"></div>

        <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
          <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
            <div class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
              <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                <div class="sm:flex sm:items-start">
                  <div class="mx-auto flex size-12 shrink-0 items-center justify-center rounded-full bg-red-100 sm:mx-0 sm:size-10">
                    <svg
                      class="size-6 text-red-600"
                      fill=""
                      viewBox="0 0 24 24"
                      stroke-width="1.5"
                      stroke="currentColor"
                      aria-hidden="true"
                      data-slot="icon"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z"
                      />
                    </svg>
                  </div>
                </div>
                <.header>
                  <%= @title %>
                  <:subtitle>Use this form to manage action.</:subtitle>
                </.header>

                <.simple_form
                  for={@form}
                  id="action-form"
                  phx-target={@myself}
                  phx-change="validate"
                  phx-submit="save"
                >
                  <.input field={@form[:label]} type="text" label="Label" />
                  <.input
                    field={@form[:color]}
                    type="select"
                    label="Color"
                    options={[
                      {"--Select Color--", nil},
                      {"Red (Danger)", "red"},
                      {"Orange (Warning)", "orange"},
                      {"Green (Safe)", "green"},
                      {"Blue (Primary)", "blue"},
                      {"Grey (Secondary)", "gray"},
                      {"White (Normal)", "white"}
                    ]}
                  />
                  <.input
                    field={@form[:comment_sheet_id]}
                    type="select"
                    label="Comment Sheet"
                    options={[
                      {"--Select a Comment Sheet--", nil}
                      | Enum.map(@comment_sheets, fn form -> {form.name, form.id} end)
                    ]}
                  />

                  <div class="px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                    <.button
                      phx-disable-with="Saving..."
                      class="inline-flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto"
                    >
                      Save Action
                    </.button>
                    <button
                      phx-click={JS.push("toggle-modal")}
                      phx-value-action-modal={@show_action_modal}
                      type="button"
                      class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                    >
                      Cancel
                    </button>
                  </div>
                </.simple_form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(%{task_type_action: action} = assigns, socket) do
    comment_sheets = Forms.get_forms_by_type("comment_sheet")

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:comment_sheets, comment_sheets)
     |> assign_new(:form, fn ->
       to_form(TaskTypes.change_action(action))
     end)}
  end

  @impl true
  def handle_event("validate", %{"action" => action_params}, socket) do
    changeset = TaskTypes.change_action(socket.assigns.task_type_action, action_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"action" => action_params}, socket) do
    action_params = Map.put(action_params, "task_type_id", socket.assigns.task_type_id)
    save_task_type_action(socket, socket.assigns.action, action_params)
  end

  defp save_task_type_action(socket, :edit, action_params) do
    case TaskTypes.update_action(socket.assigns.task_type_action, action_params) do
      {:ok, action} ->
        notify_parent({:saved, action})

        {:noreply,
         socket
         |> put_flash(:info, "Task type updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_task_type_action(socket, :new, action_params) do
    case TaskTypes.create_action(action_params) do
      {:ok, action} ->
        notify_parent({:saved, action})

        {:noreply,
         socket
         |> put_flash(:info, "Task type created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
