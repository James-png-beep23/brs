defmodule BrsWeb.BusinessRegisterLive.Components.ApplicationHistory do
  alias Brs.Applications
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{current_account: current_account}, socket) do
    {:ok,
     socket
     |> assign(:applications, Applications.list_applications(current_account))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mt-8 px-0 sm:px-0 ">
      <!-- Applications empty state -->
      <div class="px-0 sm:px-0">
        <h3 class="text-lg sm:text-2xl font-medium leading-none text-primary-500 mb-1">
          Applications
        </h3>
        <p class="text-sm mt-0 text-neutral-500">
          View the status and progress of your application, and access the outputs from here.
        </p>
        <hr class="text-primary-910 mt-[10px] mb-4" />
      </div>
      <!-- table section -->
      <div class="bg-white overflow-hidden border border-primary-910 rounded-lg">
        <!-- Search -->
        <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center space-y-3 sm:space-y-0 px-4 py-3 border-b border-gray-910">
          <form
            action=""
            class="flex-1 flex flex-col sm:flex-row justify-between sm:items-center sm:space-x-3 space-y-3
      sm:space-y-0"
            method="get"
          >
            <div class="rounded-lg flex-1 max-w-xl">
              <label for="search" class="sr-only">Search</label>
              <div class="relative text-gray-400 focus-within:text-gray-600">
                <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                  <svg
                    class="h-5 w-5"
                    x-description="Heroicon name: mini/magnifying-glass"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                      clip-rule="evenodd"
                    >
                    </path>
                  </svg>
                </div>
                <input
                  class="block w-full rounded-md border border-gray-300 bg-white py-2 pl-10 pr-3 leading-5 text-gray-900
          placeholder-gray-500 focus:border-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-primary-500
          sm:text-sm"
                  id="search"
                  name="search"
                  placeholder="Enter Application Number to Search..."
                  type="search"
                />
              </div>
            </div>

            <button
              class="inline-flex items-center justify-center sm:w-32 rounded-md border border-gray-300 bg-white px-3 py-2 text-sm space-x-2
      font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
              type="submit"
            >
              <svg
                class="h-5 w-5 text-gray-400"
                x-description="Heroicon name: mini/magnifying-glass"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                aria-hidden="true"
              >
                <path
                  fill-rule="evenodd"
                  d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                  clip-rule="evenodd"
                >
                </path>
              </svg>
              <span>Search</span>
            </button>
          </form>
        </div>
        <!-- table section -->
        <div class="hidden sm:block">
          <div class="flex flex-col">
            <div class="overflow-x-auto block scrollbar w-full align-middle">
              <div class="inline-block min-w-full py-0 align-middle">
                <div class="overflow-hidden overflow-x-scroll md:rounded-b-lg">
                  <table class="min-w-full divide-y divide-primary-910">
                    <thead>
                      <tr>
                        <th
                          scope="col"
                          class="py-3.5 pl-4 pr-3 text-left text-sm font-normal text-gray-500"
                        >
                          Application
                        </th>
                        <th
                          scope="col"
                          class="py-3.5 pl-4 pr-3 text-left text-sm font-normal text-gray-500"
                        >
                          Status
                        </th>
                        <th
                          scope="col"
                          class="py-3.5 pl-4 pr-3 text-left text-sm font-normal text-gray-500"
                        >
                          Submitted by
                        </th>
                        <th
                          scope="col"
                          class="py-3.5 pl-4 pr-3 sm:pr-6 text-right text-sm font-normal text-gray-500"
                        >
                          Action
                        </th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-primary-910 bg-white">
                      <!-- Desktop - Applications Card -->
                      <%= for application <- @applications do %>
                        <tr class="even:bg-gray-50 odd:bg-white">
                          <td class="whitespace-nowrap px-3 py-4 pl-4 text-sm text-gray-500">
                            <div>
                              <a
                                href={~p"/applications/#{application.id}"}
                                class="text-sm text-accent-600 font-medium flex items-center space-x-1"
                              >
                                <%= application.application_number %>
                              </a>
                              <div class="font-normal text-gray-500">
                                <%= application.service.name %>
                              </div>
                            </div>
                          </td>
                          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-0 text-xs font-medium text-green-500 ring-0">
                              <svg
                                class="h-1.5 w-1.5 fill-green-500"
                                viewBox="0 0 6 6"
                                aria-hidden="true"
                              >
                                <circle cx="3" cy="3" r="3"></circle>
                              </svg>
                              <%= application.status %>
                            </span>
                          </td>
                          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <div>
                              <p class="font-normal text-gray-500">
                                <%= full_name(application.submitted_by) %>
                              </p>
                              <p class="font-normal text-gray-500">
                                <%= date_format_sht(application.submitted_at) %>
                              </p>
                            </div>
                          </td>
                          <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                            <div class="inline-flex justify-start items-center space-x-3">
                              <a
                                href={~p"/applications/#{application.id}"}
                                class="inline-flex items-center rounded-md border border-gray-300 bg-white px-3 py-2 text-sm font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2"
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
                    class="flex items-center bg-white justify-between px-3  pr-4 sm:pr-6 border-t border-gray-300 py-3"
                    aria-label="Pagination"
                  >
                    <div class="enable-bootstrap">
                      <div class="btn-group">
                        <a href="/registries/brs/applications?page=1" class="btn btn-success">
                          1
                        </a>
                      </div>
                    </div>
                  </nav>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- table section -->
    <!-- Mobile table -->
        <div class="sm:hidden border-none ">
          <%= for application <- @applications do %>
            <div class="block sm:hidden mx-auto w-full border-b border-gray-910 last:border-none">
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#application-details")
                  |> JS.toggle_class("rotate-180", to: "#open-icon")
                }
                type="button"
                aria-expanded="true"
                class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-500 focus-visible:ring-opacity-75 p-3"
                aria-controls="application-details"
              >
                <div>
                  <a
                    href={~p"/applications/#{application.id}"}
                    class="text-sm text-accent-600 font-medium flex items-center space-x-1"
                  >
                    <%= application.application_number %>
                  </a>
                  <p class="text-sm font-normal text-gray-500"><%= application.service.name %></p>
                </div>
                <span class="flex justify-center items-center text-[#C9CED5] rounded border border-[#C9CED5] h-5 w-5 focus:border-transparent focus:outline-none focus-within:text-primary-500 focus:ring-1 focus:ring-primary-500">
                  <svg
                    id="open-icon"
                    class="h-1.5 w-2.5 transition-transform ease-linear duration-300 rotate-0 transform"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 10 6"
                  >
                    <path
                      fill="currentColor"
                      fill-rule="evenodd"
                      d="M.293.293a1 1 0 0 1 1.414 0L5 3.586 8.293.293a1 1 0 0 1 1.414 1.414l-4 4a1 1 0 0 1-1.414 0l-4-4a1 1 0 0 1 0-1.414Z"
                      clip-rule="evenodd"
                    >
                    </path>
                  </svg>
                </span>
              </button>
              <div id="application-details" class="hidden">
                <div class="space-y-4 border-t mt-0 pt-4 grid grid-cols-2 bg-backdrop p-3">
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Application ID</p>
                    <p class="text-sm font-medium text-gray-900"><%= application.application_number %></p>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Application Name</p>
                    <p class="text-sm font-medium text-gray-900"> <%= application.service.name %></p>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Status</p>
                    <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-0 text-xs font-medium text-primary-500 ring-0">
                      <svg class="h-1.5 w-1.5 fill-primary-500" viewBox="0 0 6 6" aria-hidden="true">
                        <circle cx="3" cy="3" r="3"></circle>
                      </svg>
                      <%= application.status %>
                    </span>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Submitted by</p>
                    <p class="text-sm font-medium text-gray-900"><%= full_name(application.submitted_by) %></p>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Date Submitted</p>
                    <p class="text-sm font-medium text-gray-900"><%= date_format_sht(application.submitted_at) %></p>
                  </div>
                </div>
                <div class="mt-0 flex justify-end border-t p-3 bg-backdrop">
                  <a
                    href={~p"/applications/#{application.id}"}
                    class="items-center min-w-[70px] text-center px-2 py-1 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-100"
                  >
                    View
                  </a>
                </div>
              </div>
            </div>
          <% end %>
        </div>
        <!-- Mobile table -->
      </div>
      <!-- table section -->
    </div>
    """
  end
end
