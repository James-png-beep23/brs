defmodule BrsWeb.ClientLive.Components.SearchClientComponent do
  use BrsWeb, :live_component
  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4 md:space-y-4">
      <%= if length(@clients) > 0 do %>
        <!-- filled state -->
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
                          Client
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          ID/PP NO.
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          Phone
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          Email Address
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          Client Type
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-sm font-medium text-gray-600 text-right"
                        >
                          Action
                        </th>
                      </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                      <%= for client <- @clients do %>
                        <%= if client.user do %>
                          <tr>
                            <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                              <div>
                                <p class="text-sm font-medium text-gray-900">
                                  <%= full_name(client.user) %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  <%= client.user.id_number %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  <%= client.user.phone_number %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  <%= client.user.email %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  <%= client.user.id_type.label %>
                                </p>
                              </div>
                            </td>
                            <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                              <div class="inline-flex items-center justify-end space-x-3 text-right">
                                <a
                                  href={
                                    ~p"/admin/registries/#{@current_registry.slug}/clients/#{client.id}"
                                  }
                                  class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                                >
                                  View
                                </a>
                              </div>
                            </td>
                          </tr>
                        <% else %>
                          <tr>
                            <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                              <div>
                                <p class="text-sm font-medium text-gray-900">
                                  <%= client.business.name %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  <%= client.business.registration_number %>
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  N/A
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  N/A
                                </p>
                              </div>
                            </td>
                            <td class="px-3 py-4 text-sm text-gray-500">
                              <div>
                                <p class="text-sm font-normal text-gray-500">
                                  Business
                                </p>
                              </div>
                            </td>
                            <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                              <div class="inline-flex items-center justify-end space-x-3 text-right">
                                <a
                                  href={
                                    ~p"/admin/registries/#{@current_registry.slug}/clients/#{client.id}"
                                  }
                                  class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                                >
                                  View
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
                <%= for client <- @clients do %>
                  <%= if client.user do %>
                    <div class="w-full p-3 mx-auto">
                      <button
                        type="button"
                        aria-expanded="true"
                        class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                        aria-controls="headlessui-disclosure-panel-119"
                      >
                        <div>
                          <p class="mb-2 text-sm font-medium text-gray-900">Client</p>
                          <p class="text-sm font-medium text-gray-700">
                            <%= full_name(client.user) %>
                          </p>
                        </div>
                        <span
                          phx-click={
                            JS.toggle(
                              to: "#client-card#{client.id}",
                              in: "block",
                              out: "hidden"
                            )
                            |> JS.toggle_class(
                              "rotate-0 rotate-180",
                              to: "#client-card-icon#{client.id}"
                            )
                          }
                          class="inline-block p-0.5 border rounded-md border-gray-400"
                        >
                          <svg
                            id={"client-card-icon#{client.id}"}
                            class="w-5 h-5 text-gray-500 rotate-180"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="2"
                            stroke="currentColor"
                            aria-hidden="true"
                          >
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7">
                            </path>
                          </svg>
                        </span>
                      </button>
                      <div id={"client-card#{client.id}"} class="hidden">
                        <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">ID/PP NO.</p>
                            <p class="text-sm font-normal text-gray-900">
                              <%= client.user.id_number %>
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Phone</p>
                            <p class="text-sm font-normal text-gray-900">
                              <%= client.user.phone_number %>
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Email Address</p>
                            <p class="text-sm font-normal text-gray-900">
                              <%= client.user.email %>
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Client Type</p>
                            <p class="text-sm font-normal text-gray-900">
                              <%= client.user.id_type.label %>
                            </p>
                          </div>
                        </div>
                        <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                          <a
                            hhref={
                              ~p"/admin/registries/#{@current_registry.slug}/clients/#{client.id}"
                            }
                            class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                          >
                            View
                          </a>
                        </div>
                      </div>
                    </div>
                  <% else %>
                    <div class="w-full p-3 mx-auto">
                      <button
                        type="button"
                        aria-expanded="true"
                        class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                        aria-controls="headlessui-disclosure-panel-119"
                      >
                        <div>
                          <p class="mb-2 text-sm font-medium text-gray-900">Client</p>
                          <p class="text-sm font-medium text-gray-700"><%= client.business.name %></p>
                        </div>
                        <span
                          phx-click={
                            JS.toggle(
                              to: "#client-card#{client.id}",
                              in: "block",
                              out: "hidden"
                            )
                            |> JS.toggle_class(
                              "rotate-0 rotate-180",
                              to: "#client-card-icon#{client.id}"
                            )
                          }
                          class="inline-block p-0.5 border rounded-md border-gray-400"
                        >
                          <svg
                            id={"client-card-icon#{client.id}"}
                            class="w-5 h-5 text-gray-500 rotate-180"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="2"
                            stroke="currentColor"
                            aria-hidden="true"
                          >
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7">
                            </path>
                          </svg>
                        </span>
                      </button>
                      <div id={"client-card#{client.id}"} class="hidden">
                        <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">ID/PP NO.</p>
                            <p class="text-sm font-normal text-gray-900">
                              <%= client.business.registration_number %>
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Phone</p>
                            <p class="text-sm font-normal text-gray-900">
                              N/A
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Email Address</p>
                            <p class="text-sm font-normal text-gray-900">
                              N/A
                            </p>
                          </div>
                          <div class="col-span-1">
                            <p class="text-xs text-gray-600">Client Type</p>
                            <p class="text-sm font-normal text-gray-900">
                              Business
                            </p>
                          </div>
                        </div>
                        <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                          <a
                            hhref={
                              ~p"/admin/registries/#{@current_registry.slug}/clients/#{client.id}"
                            }
                            class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                          >
                            View
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
      <% else %>
        <!-- empty state -->
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
                          Client
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          ID/PP NO.
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          Phone
                        </th>
                        <th
                          scope="col"
                          class="px-3 py-2.5 text-left text-sm font-medium text-gray-600"
                        >
                          Email Address
                        </th>
                        <th scope="col" class="px-3 py-2.5 text-sm font-medium text-gray-600">
                          Client Type
                        </th>
                      </tr>
                    </thead>
                  </table>
                  <div class="flex items-center justify-center px-5 py-10 bg-white md:space-y-20">
                    <div class="space-y-2">
                      <div class="text-center">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          class="m-auto"
                          width="150"
                          height="151"
                          viewBox="0 0 150 151"
                          fill="none"
                        >
                          <path
                            d="M75 150C116.421 150 150 116.421 150 75C150 33.5786 116.421 0 75 0C33.5786 0 0 33.5786 0 75C0 116.421 33.5786 150 75 150Z"
                            fill="#E2E3E9"
                          />
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M27.0998 79.4409H68.7633C69.824 79.4411 70.8683 79.1794 71.8035 78.6791C72.7388 78.1789 73.5362 77.4555 74.1249 76.5732L83.1665 62.9818C83.7563 62.0955 84.5564 61.3692 85.4954 60.8676C86.4345 60.366 87.4831 60.1049 88.5477 60.1074H117.322C124.44 60.1074 130.211 65.8781 130.211 72.9964V137.441C130.211 144.559 124.44 150.33 117.322 150.33H27.0998C19.9816 150.33 14.2109 144.559 14.2109 137.441V92.3299C14.2109 85.2116 19.9816 79.4409 27.0998 79.4409Z"
                            fill="white"
                          />
                          <path
                            d="M62.2324 98.9912V104.068M82.5424 98.9912V104.068"
                            stroke="#E2E3E9"
                            stroke-width="7.15208"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M90.159 122.793C90.159 122.793 83.4978 129.454 72.3889 129.454C61.2803 129.454 54.6191 122.793 54.6191 122.793"
                            stroke="#E2E3E9"
                            stroke-width="7.15208"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M122.089 102.538H108.938C102.362 102.538 99.0742 105.826 99.0742 112.402V133.772C99.0742 134.676 99.814 135.416 100.718 135.416H122.089C128.664 135.416 131.952 132.128 131.952 125.553V112.402C131.952 105.826 128.664 102.538 122.089 102.538Z"
                            fill="#D6D9E0"
                          />
                          <path
                            d="M111.984 116.484V113.631C111.984 111.53 113.698 109.826 115.811 109.826C117.924 109.826 119.637 111.53 119.637 113.631V116.484"
                            stroke="white"
                            stroke-width="1.68106"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M121.361 128.826H110.295C109.072 128.826 108.082 127.835 108.082 126.612V118.866C108.082 117.644 109.072 116.653 110.295 116.653H121.361C122.584 116.653 123.574 117.644 123.574 118.866V126.612C123.574 127.835 122.584 128.826 121.361 128.826Z"
                            fill="white"
                            stroke="white"
                            stroke-width="0.990507"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M115.753 120.966C115.302 120.966 114.936 121.331 114.939 121.782C114.939 122.233 115.305 122.598 115.756 122.598C116.206 122.598 116.572 122.233 116.572 121.782C116.572 121.331 116.206 120.966 115.753 120.966M115.756 125.394V122.619V125.394Z"
                            stroke="#D6D9E0"
                            stroke-width="2.06682"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </div>

                      <p class="mt-0 text-base font-medium text-gray-500">
                        Search for a specific record to display here.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <!-- mobile Desktop -->
              <div class="block w-full align-middle sm:hidden">
                <div class="overflow-x-auto bg-white divide-y divide-gray-200 rounded-lg shadow ring-1 ring-black ring-opacity-5">
                  <div class="flex items-center justify-center px-5 py-10 bg-white md:space-y-20">
                    <div class="space-y-2">
                      <div class="text-center">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          class="m-auto"
                          width="150"
                          height="151"
                          viewBox="0 0 150 151"
                          fill="none"
                        >
                          <path
                            d="M75 150C116.421 150 150 116.421 150 75C150 33.5786 116.421 0 75 0C33.5786 0 0 33.5786 0 75C0 116.421 33.5786 150 75 150Z"
                            fill="#E2E3E9"
                          />
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M27.0998 79.4409H68.7633C69.824 79.4411 70.8683 79.1794 71.8035 78.6791C72.7388 78.1789 73.5362 77.4555 74.1249 76.5732L83.1665 62.9818C83.7563 62.0955 84.5564 61.3692 85.4954 60.8676C86.4345 60.366 87.4831 60.1049 88.5477 60.1074H117.322C124.44 60.1074 130.211 65.8781 130.211 72.9964V137.441C130.211 144.559 124.44 150.33 117.322 150.33H27.0998C19.9816 150.33 14.2109 144.559 14.2109 137.441V92.3299C14.2109 85.2116 19.9816 79.4409 27.0998 79.4409Z"
                            fill="white"
                          />
                          <path
                            d="M62.2324 98.9912V104.068M82.5424 98.9912V104.068"
                            stroke="#E2E3E9"
                            stroke-width="7.15208"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M90.159 122.793C90.159 122.793 83.4978 129.454 72.3889 129.454C61.2803 129.454 54.6191 122.793 54.6191 122.793"
                            stroke="#E2E3E9"
                            stroke-width="7.15208"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M122.089 102.538H108.938C102.362 102.538 99.0742 105.826 99.0742 112.402V133.772C99.0742 134.676 99.814 135.416 100.718 135.416H122.089C128.664 135.416 131.952 132.128 131.952 125.553V112.402C131.952 105.826 128.664 102.538 122.089 102.538Z"
                            fill="#D6D9E0"
                          />
                          <path
                            d="M111.984 116.484V113.631C111.984 111.53 113.698 109.826 115.811 109.826C117.924 109.826 119.637 111.53 119.637 113.631V116.484"
                            stroke="white"
                            stroke-width="1.68106"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M121.361 128.826H110.295C109.072 128.826 108.082 127.835 108.082 126.612V118.866C108.082 117.644 109.072 116.653 110.295 116.653H121.361C122.584 116.653 123.574 117.644 123.574 118.866V126.612C123.574 127.835 122.584 128.826 121.361 128.826Z"
                            fill="white"
                            stroke="white"
                            stroke-width="0.990507"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                          <path
                            d="M115.753 120.966C115.302 120.966 114.936 121.331 114.939 121.782C114.939 122.233 115.305 122.598 115.756 122.598C116.206 122.598 116.572 122.233 116.572 121.782C116.572 121.331 116.206 120.966 115.753 120.966M115.756 125.394V122.619V125.394Z"
                            stroke="#D6D9E0"
                            stroke-width="2.06682"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </div>

                      <p class="mt-0 text-base font-medium text-center text-gray-500">
                        Search for a specific record to display here.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
