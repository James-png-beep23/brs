defmodule BrsWeb.TaskTypeLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.TaskTypes

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id="task-type-modal"
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
                <:subtitle>Use this form to manage task_type records.</:subtitle>
                <:actions>
                  <div class="absolute top-6 right-5">
                    <button
                      phx-click={
                        JS.push("close-modal") |> JS.toggle_class("hidden", to: "#task-type-modal")
                      }
                      type="button"
                      class="flex-none p-3 -m-3 opacity-20 hover:opacity-40"
                      aria-label={gettext("close")}
                    >
                      <.icon name="hero-x-mark-solid" class="w-5 h-5" />
                    </button>
                  </div>
                </:actions>
              </.header>
              <.simple_form
                for={@form}
                id="task_type-form"
                phx-target={@myself}
                phx-change="validate"
                phx-submit="save"
              >
                <.input field={@form[:name]} type="text" label="Name" />
                <.input field={@form[:semantic_id]} type="text" label="Semantic" />
                <.input field={@form[:allow_corrections]} type="checkbox" label="Allow corrections" />
                <.input field={@form[:auto_assignable]} type="checkbox" label="Auto assignable" />
                <:actions>
                  <.button phx-disable-with="Saving...">Save Task type</.button>
                </:actions>
              </.simple_form>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(%{task_type: task_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(TaskTypes.change_task_type(task_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"task_type" => task_type_params}, socket) do
    changeset = TaskTypes.change_task_type(socket.assigns.task_type, task_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"task_type" => task_type_params}, socket) do
    task_type_params = Map.put(task_type_params, "service_id", socket.assigns.service_id)
    save_task_type(socket, socket.assigns.action, task_type_params)
  end

  defp save_task_type(socket, :edit, task_type_params) do
    case TaskTypes.update_task_type(socket.assigns.task_type, task_type_params) do
      {:ok, _task_type} ->
        notify_parent({:saved, "Task type updated successfully"})

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_task_type(socket, :new, task_type_params) do
    case TaskTypes.create_task_type(task_type_params) do
      {:ok, _task_type} ->
        notify_parent({:saved, "Task type created successfully"})

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
