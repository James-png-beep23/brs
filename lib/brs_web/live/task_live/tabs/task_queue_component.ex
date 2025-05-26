defmodule BrsWeb.TaskLive.Tabs.TaskQueueComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    # Sample tasks
    tasks = [
      %{id: 1, name: "Annual Return Review", count: 300},
      %{id: 2, name: "Name Search Review", count: 50}
    ]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(tasks: tasks)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- table content -->
      <div class="flex flex-col mb-4">
        <div class="sm:overflow-auto lg:overflow-visible">
          <!-- Table Desktop -->
          <div class="hidden w-full align-middle sm:block">
            <div class="pb-4 divide-y divide-gray-200 rounded-lg shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0">
              <table class="min-w-full divide-y divide-gray-300 table-auto">
                <thead class="bg-gray-50">
                  <tr>
                    <th
                      scope="col"
                      class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-600 sm:pl-4"
                    >
                      Task Category
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Count
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-sm font-medium text-gray-600 text-right">
                      Action
                    </th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <%= if length(@tasks) > 0 do %>
                    <%= for task <- @tasks do %>
                      <tr>
                        <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                          <div>
                            <p class="text-sm font-medium text-gray-900">
                              <%= task.name %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500">
                              <%= task.count %>
                            </p>
                          </div>
                        </td>
                        <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                          <div class="inline-flex items-center justify-end space-x-3 text-right">
                            <a
                              href={~p"/admin/tasks/#{task.id}"}
                              class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 text-white border rounded-md shadow-sm border-primary-500 bg-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                            >
                              Pick
                            </a>
                          </div>
                        </td>
                      </tr>
                    <% end %>
                  <% end %>
                </tbody>
              </table>
              <nav
                class="flex items-center justify-between px-3 py-3 pr-4 bg-white border-t border-gray-300 sm:pr-6"
                aria-label="Pagination"
              >
                <div class="block">
                  <p class="text-sm text-gray-700">
                    Showing <span class="font-medium">1</span>
                    to <span class="font-medium">2</span>
                    of <span class="font-medium">2</span>
                    results
                  </p>
                </div>
                <div class="flex justify-between sm:justify-end">
                  <!-- Active:  class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"  -->
                  <a
                    href="#"
                    class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                  >
                    Previous
                  </a>
                  <a
                    href="#"
                    class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                  >
                    Next
                  </a>
                </div>
              </nav>
            </div>
          </div>
          <!-- Mobile table -->
          <div class="block bg-white divide-y divide-gray-300 rounded-lg shadow sm:hidden">
            <%= if length(@tasks) > 0 do %>
              <%= for {task, index} <- Enum.with_index(@tasks) do %>
                <div class="w-full p-3 mx-auto">
                  <button
                    type="button"
                    aria-expanded="true"
                    class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                    aria-controls="headlessui-disclosure-panel-119"
                  >
                    <div>
                      <p class="mb-2 text-sm font-medium text-gray-900">Task Category</p>
                      <p class="text-sm font-medium text-gray-700"><%= task.name %></p>
                    </div>
                    <span
                      phx-click={
                        JS.toggle(
                          to: "#mobile-expanded-task-card#{index}",
                          in: "fade-in-scale",
                          out: "fade-out-scale"
                        )
                        |> JS.toggle_class(
                          "rotate-0 rotate-180",
                          to: "#mobile-card-icon#{index}"
                        )
                      }
                      class="inline-block p-0.5 border rounded-md border-gray-400"
                    >
                      <svg
                        id={"mobile-card-icon#{index}"}
                        class="w-5 h-5 text-gray-500"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke-width="2"
                        stroke="currentColor"
                        aria-hidden="true"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7"></path>
                      </svg>
                    </span>
                  </button>
                  <div id={"mobile-expanded-task-card#{index}"}>
                    <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Task Category</p>
                        <p class="text-sm font-normal text-gray-900">
                          <%= task.name %>
                        </p>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Count</p>
                        <div>
                          <p class="text-sm font-normal text-gray-900">
                            <%= task.count %>
                          </p>
                        </div>
                      </div>
                    </div>
                    <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                      <a
                        href={~p"/admin/tasks/#{task.id}"}
                        class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                      >
                        Pick
                      </a>
                    </div>
                  </div>
                </div>
              <% end %>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
