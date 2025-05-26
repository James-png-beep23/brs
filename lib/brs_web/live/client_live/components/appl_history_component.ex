defmodule BrsWeb.ClientLive.ApplHistoryComponent do
  use BrsWeb, :live_component

  @impl true
  def update(%{client: client} = assigns, socket) do
    current_registry = assigns.current_registry

    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       :applications,
       Brs.Applications.list_applications_by_registry(client, current_registry)
     )}
  end

  def update(%{applications: applications} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:applications, applications)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div>
        <.live_component
          module={BrsWeb.Shared.ApplicationSearchComponent}
          id="application-search"
          phx-target={@myself}
          current_registry={@current_registry}
        />
      </div>

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
                        App NO.
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Service
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Stage
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Submitted
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-sm font-medium text-gray-600 text-right">
                        Action
                      </th>
                    </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-gray-200">
                    <%= for application <- @applications do %>
                      <tr>
                        <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                          <div>
                            <p class="text-sm font-medium text-gray-900">
                              <%= application.application_number %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500">
                              <%= application.service.name %>
                            </p>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-orange-700 ring-1 ring-inset ring-transparent">
                              <svg
                                class="h-1.5 w-1.5 fill-orange-400"
                                viewBox="0 0 6 6"
                                aria-hidden="true"
                              >
                                <circle cx="3" cy="3" r="3" />
                              </svg>
                              <%= application.status %>
                            </span>
                          </div>
                        </td>
                        <td class="px-3 py-4 text-sm text-gray-500">
                          <div>
                            <p class="text-sm font-normal text-gray-500">
                              <%= date_format_sht(application.submitted_at) %>
                            </p>
                          </div>
                        </td>
                        <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                          <div class="inline-flex items-center justify-end space-x-3 text-right">
                            <a
                              href={
                                ~p"/admin/registries/#{@current_registry.slug}/applications/#{application.id}"
                              }
                              class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                            >
                              View
                            </a>
                          </div>
                        </td>
                      </tr>
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
              <%= for application <- @applications do %>
                <div class="w-full p-3 mx-auto">
                  <button
                    type="button"
                    aria-expanded="true"
                    class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                    aria-controls="headlessui-disclosure-panel-119"
                  >
                    <div>
                      <p class="mb-2 text-sm font-medium text-gray-900">App NO.</p>
                      <p class="text-sm font-medium text-gray-700">
                        <%= application.application_number %>
                      </p>
                    </div>
                    <span
                      phx-click={
                        JS.toggle(
                          to: "#application-card#{application.id}",
                          in: "block",
                          out: "hidden"
                        )
                        |> JS.toggle_class(
                          "rotate-0 rotate-180",
                          to: "#application-card-icon#{application.id}"
                        )
                      }
                      class="inline-block p-0.5 border rounded-md border-gray-400"
                    >
                      <svg
                        id={"application-card-icon#{application.id}"}
                        class="w-5 h-5 text-gray-500 rotate-180"
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
                  <div id={"application-card#{application.id}"} class="hidden">
                    <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">App NO.</p>
                        <p class="text-sm font-normal text-gray-900">
                          <%= application.application_number %>
                        </p>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Service</p>
                        <p class="text-sm font-normal text-gray-900">
                          <%= application.service.name %>
                        </p>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Status</p>
                        <div>
                          <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-orange-700 ring-1 ring-inset ring-transparent">
                            <svg
                              class="h-1.5 w-1.5 fill-orange-400"
                              viewBox="0 0 6 6"
                              aria-hidden="true"
                            >
                              <circle cx="3" cy="3" r="3" />
                            </svg>
                            <%= application.status %>
                          </span>
                        </div>
                      </div>
                      <div class="col-span-1">
                        <p class="text-xs text-gray-600">Submitted by</p>
                        <div>
                          <p class="text-sm font-normal text-gray-900">
                            <%= date_format_sht(application.submitted_at) %>
                          </p>
                        </div>
                      </div>
                    </div>
                    <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                      <a
                        href={
                          ~p"/admin/registries/#{@current_registry.slug}/applications/#{application.id}"
                        }
                        class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                      >
                        View
                      </a>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
