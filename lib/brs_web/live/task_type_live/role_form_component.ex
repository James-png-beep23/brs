defmodule BrsWeb.TaskTypeLive.RoleFormComponent do
  alias Brs.Services
  alias Brs.Accounts
  use BrsWeb, :live_component

  alias Brs.TaskTypes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div
        id="role-modal"
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
                  <:subtitle>Use this form to manage roles.</:subtitle>
                </.header>

                <.simple_form
                  for={@form}
                  id="action-form"
                  phx-target={@myself}
                  phx-change="validate"
                  phx-submit="save"
                >
                  <.input field={@form[:task_type_id]} type="hidden" value={@task_type_id} />
                  <.label>Roles</.label>
                  <div
                    id="dropdown"
                    class="relative w-full"
                    phx-click-away={JS.add_class("hidden", to: "#dropdown-menu")}
                  >
                    <!-- Select Input -->
                    <div
                      phx-click={JS.toggle(to: "#dropdown-menu")}
                      class="border rounded-lg p-2 flex justify-between items-center cursor-pointer "
                    >
                      <div>
                        <!-- Selected Items -->
                        <div id="selected-items" class="flex flex-wrap gap-1">
                          <%= if @selected_items == [] do %>
                            <span class="text-gray-500">Select...</span>
                          <% else %>
                            <%= for role <- @selected_items do %>
                              <span class="inline-flex items-center bg-blue-500 text-white text-sm px-2 py-1 rounded-md">
                                <%= role.name %>
                                <button
                                  type="button"
                                  phx-click="remove_item"
                                  phx-value-item={role.id}
                                  phx-target={@myself}
                                  class="ml-1 text-white hover:text-red-500"
                                >
                                  &times;
                                </button>
                              </span>
                            <% end %>
                          <% end %>
                        </div>
                      </div>
                      <svg
                        class="w-4 h-4"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7">
                        </path>
                      </svg>
                    </div>
                    <!-- Dropdown Options -->
                    <div
                      id="dropdown-menu"
                      class="relative bg-white border rounded-lg mt-1 w-full z-30"
                      style="display: none;"
                    >
                      <input
                        type="text"
                        placeholder="Search..."
                        phx-keyup="search"
                        phx-debounce="300"
                        phx-target={@myself}
                        class="w-full p-2 border-b"
                      />

                      <ul class="max-h-40 overflow-auto">
                        <%= for option <- @filtered_roles do %>
                          <li
                            phx-target={@myself}
                            phx-click="select_item"
                            phx-value-item={option.id}
                            class="p-2 cursor-pointer hover:bg-blue-500 hover:text-white"
                          >
                            <%= option.name %>
                          </li>
                        <% end %>
                      </ul>
                    </div>
                  </div>

                  <div class="px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                    <.button
                      phx-disable-with="Saving..."
                      class="inline-flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto"
                    >
                      Save Role
                    </.button>
                    <button
                      phx-click={JS.push("toggle-modal")}
                      phx-value-role-modal={@show_role_modal}
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
  def update(%{task_type_role: role} = assigns, socket) do
    service =
      assigns[:service_id]
      |> Services.get_service!()

    roles = (service && Accounts.get_roles_by_registry(service.registry.id)) || []

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:roles, roles)
     |> assign(
       selected_items: [],
       filtered_roles: roles,
       dropdown_open: false
     )
     |> assign_new(:form, fn ->
       to_form(TaskTypes.change_role(role))
     end)}
  end

  @impl true
  def handle_event("validate", %{"role" => role_params}, socket) do
    changeset = TaskTypes.change_role(socket.assigns.task_type_role, role_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"role" => role_params}, socket) do
    role_params = Map.put(role_params, "task_type_id", socket.assigns.task_type_id)
    save_task_type_role(socket, socket.assigns.action, role_params)
  end

  def handle_event("search", %{"value" => query}, socket) do
    filtered_options =
      socket.assigns.roles
      |> Enum.filter(fn role ->
        String.contains?(String.downcase(role.name), String.downcase(query))
      end)

    {:noreply, assign(socket, :filtered_roles, filtered_options)}
  end

  def handle_event("select_item", %{"item" => item}, socket) do
    role = Enum.find(socket.assigns.roles, &(&1.id == String.to_integer(item)))

    {:noreply, assign(socket, :selected_items, Enum.uniq([role | socket.assigns.selected_items]))}
  end

  def handle_event("remove_item", %{"item" => item}, socket) do
    selected_items =
      socket.assigns.selected_items |> Enum.reject(&(&1.id == String.to_integer(item)))

    {:noreply, assign(socket, :selected_items, selected_items)}
  end

  defp save_task_type_role(socket, :new, role_params) do
    updated_role_params =
      Enum.map(socket.assigns.selected_items, fn role ->
        Map.put(role_params, "role_id", role.id)
      end)

    results =
      Enum.map(updated_role_params, fn params ->
        TaskTypes.create_role(params)
      end)

    {ok_roles, errors} =
      Enum.split_with(results, fn
        {:ok, _role} -> true
        {:error, _changeset} -> false
      end)

    if errors == [] do
      Enum.each(ok_roles, fn {:ok, role} ->
        notify_parent({:saved, role})
      end)

      {:noreply,
       socket
       |> put_flash(:info, "All roles created successfully")}
    else
      {:error, changeset} = List.first(errors)

      {:noreply,
       socket
       |> put_flash(:error, "Some roles could not be created")
       |> assign(form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
