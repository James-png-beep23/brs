defmodule BrsWeb.CompanyLive.Tabs.AccessControlComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section>
      <div class="space-y-4">
        <!-- table content -->
        <div class="flex flex-col mb-4">
          <div class="sm:overflow-auto lg:overflow-visible">
            <!-- Table Desktop -->
            <div class="hidden w-full align-middle sm:block">
              <div class="pb-4 divide-y divide-gray-200 rounded-lg shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0">
                <div class="px-4 py-3 bg-white">
                  <p class="mb-1 text-sm text-gray-700">Search for a User</p>
                  <div class="flex items-center space-x-4">
                    <div class="flex-1">
                      <!-- search -->
                      <form class="flex w-full md:ml-0" action="#" method="GET">
                        <label for="search-field" class="sr-only">Search</label>
                        <div class="relative w-full text-gray-400 bg-white rounded-full focus-within:text-gray-600">
                          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                            <svg
                              width="20"
                              height="20"
                              viewBox="0 0 20 20"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M17.5 17.5L14.5834 14.5833M16.6667 9.58333C16.6667 13.4954 13.4954 16.6667 9.58333 16.6667C5.67132 16.6667 2.5 13.4954 2.5 9.58333C2.5 5.67132 5.67132 2.5 9.58333 2.5C13.4954 2.5 16.6667 5.67132 16.6667 9.58333Z"
                                stroke="#9CA3AF"
                                stroke-width="1.66667"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              >
                              </path>
                            </svg>
                          </div>
                          <input
                            id="search-field"
                            value=""
                            class="block w-full py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-400 border border-gray-300 rounded-lg focus:outline-none focus:ring-1 focus:ring-offset-0 focus:ring-primary-600 sm:text-base sm:leading-5"
                            placeholder="Search"
                            type="search"
                            name="Search filed returns"
                          />
                        </div>
                      </form>
                    </div>
                    <button class="flex items-center px-4 py-2 ml-3 space-x-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100">
                      <svg
                        class="w-4 h-4"
                        width="20"
                        height="20"
                        viewBox="0 0 20 20"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M9.99985 13C6.82977 13 4.01065 14.5306 2.21585 16.906C1.82956 17.4172 1.63641 17.6728 1.64273 18.0183C1.64761 18.2852 1.81521 18.6219 2.02522 18.7867C2.29704 19 2.67372 19 3.42708 19H16.5726C17.326 19 17.7027 19 17.9745 18.7867C18.1845 18.6219 18.3521 18.2852 18.357 18.0183C18.3633 17.6728 18.1701 17.4172 17.7839 16.906C15.9891 14.5306 13.1699 13 9.99985 13Z"
                          stroke="#344054"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                        <path
                          d="M9.99985 10C12.4851 10 14.4999 7.98528 14.4999 5.5C14.4999 3.01472 12.4851 1 9.99985 1C7.51457 1 5.49985 3.01472 5.49985 5.5C5.49985 7.98528 7.51457 10 9.99985 10Z"
                          stroke="#344054"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span class="inline-block text-base font-semibold leading-5">
                        Add User
                      </span>
                    </button>
                  </div>
                </div>

                <table class="min-w-full divide-y divide-gray-300 table-auto">
                  <thead class="bg-gray-50">
                    <tr>
                      <th
                        scope="col"
                        class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-800 sm:pl-4 capitalize"
                      >
                        Customer
                      </th>
                      <th
                        scope="col"
                        class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                      >
                        About
                      </th>
                      <th
                        scope="col"
                        class="px-3 py-2.5 text-right text-sm font-medium text-gray-800 capitalize"
                      >
                        <span class="sr-only">Action</span>
                      </th>
                    </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-gray-200">
                    <tr>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        <div class="flex items-center gap-3">
                          <p class="text-gray-800 text-sm font-medium p-1.5 rounded-full bg-gray-100">
                            OR
                          </p>
                          <div class="text-sm">
                            <p class="font-medium text-gray-900">Larry Weya</p>
                            <p class="text-gray-500">Director</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        <div class="text-sm">
                          <p class="font-medium text-gray-900">Full Admin Access</p>
                          <p class="text-gray-500">
                            Can make applications, change particulars and manage users
                          </p>
                        </div>
                      </td>

                      <td class="px-3 py-4 text-sm text-right text-gray-700 whitespace-nowrap"></td>
                    </tr>
                    <tr>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        <div class="flex items-center gap-3">
                          <p class="text-gray-800 text-sm font-medium p-1.5 rounded-full bg-gray-100">
                            OR
                          </p>
                          <div class="text-sm">
                            <p class="font-medium text-gray-900">Larry Weya</p>
                            <p class="text-gray-500">Director</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        <div class="text-sm">
                          <p class="font-medium text-gray-900">Operations</p>
                          <p class="text-gray-500">Can make applications</p>
                        </div>
                      </td>

                      <td class="px-3 py-4 text-sm text-right text-gray-700 whitespace-nowrap">
                        <div class="flex items-center justify-end w-full space-x-3">
                          <button class="text-sm font-semibold text-gray-800 transition-colors hover:text-gray-500">
                            Edit
                          </button>
                          <button class="text-sm font-semibold text-red-600 transition-colors hover:text-red-900">
                            Remove
                          </button>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- Table Mobile -->
            <div class="w-full bg-white rounded-lg sm:hidden">
              <div class="flex flex-col px-4 py-3 bg-white border-b border-gray-200 sm:flex-row">
                <p class="mb-1 text-sm text-gray-500">Search for a User</p>
                <div class="flex flex-col gap-4 sm:flex-row">
                  <div class="flex-1">
                    <!-- search -->
                    <form class="flex w-full md:ml-0" action="#" method="GET">
                      <label for="search-field" class="sr-only">Search</label>
                      <div class="relative w-full text-gray-400 bg-white rounded-full focus-within:text-gray-600">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                          <svg
                            width="20"
                            height="20"
                            viewBox="0 0 20 20"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              d="M17.5 17.5L14.5834 14.5833M16.6667 9.58333C16.6667 13.4954 13.4954 16.6667 9.58333 16.6667C5.67132 16.6667 2.5 13.4954 2.5 9.58333C2.5 5.67132 5.67132 2.5 9.58333 2.5C13.4954 2.5 16.6667 5.67132 16.6667 9.58333Z"
                              stroke="#9CA3AF"
                              stroke-width="1.66667"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            >
                            </path>
                          </svg>
                        </div>
                        <input
                          id="search-field"
                          value=""
                          class="block w-full py-3 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-400 border border-gray-300 rounded-lg focus:outline-none focus:ring-1 focus:ring-offset-0 focus:ring-primary-600 sm:text-base sm:leading-5"
                          placeholder="Search"
                          type="search"
                          name="Search filed returns"
                        />
                      </div>
                    </form>
                  </div>
                  <button class="flex items-center self-start px-4 py-2 space-x-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100">
                    <svg
                      width="20"
                      height="20"
                      viewBox="0 0 20 20"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M9.99985 13C6.82977 13 4.01065 14.5306 2.21585 16.906C1.82956 17.4172 1.63641 17.6728 1.64273 18.0183C1.64761 18.2852 1.81521 18.6219 2.02522 18.7867C2.29704 19 2.67372 19 3.42708 19H16.5726C17.326 19 17.7027 19 17.9745 18.7867C18.1845 18.6219 18.3521 18.2852 18.357 18.0183C18.3633 17.6728 18.1701 17.4172 17.7839 16.906C15.9891 14.5306 13.1699 13 9.99985 13Z"
                        stroke="#344054"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                      <path
                        d="M9.99985 10C12.4851 10 14.4999 7.98528 14.4999 5.5C14.4999 3.01472 12.4851 1 9.99985 1C7.51457 1 5.49985 3.01472 5.49985 5.5C5.49985 7.98528 7.51457 10 9.99985 10Z"
                        stroke="#344054"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                    <span class="inline-block text-base font-semibold"> Add User</span>
                  </button>
                </div>
              </div>
              <div x-data="{openProfile: false}" class="w-full bg-white border-b border-gray-300">
                <div>
                  <button
                    @click="openProfile = !openProfile"
                    type="button"
                    aria-expanded="false"
                    class="flex items-center justify-between w-full px-4 py-3 text-sm font-medium text-left focus:outline-none"
                  >
                    <div class="flex items-center gap-3">
                      <p class="text-gray-800 text-sm font-medium p-1.5 rounded-full bg-gray-100">
                        OR
                      </p>
                      <div class="text-sm">
                        <p class="font-medium text-gray-900">Larry Weya</p>
                        <p class="text-gray-500">Director</p>
                      </div>
                    </div>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      x-bind:class="{'rotate-0': !openProfile, 'rotate-180': openProfile}"
                      class="w-4 h-4 transition-all"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      stroke-width="2"
                    >
                      <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"></path>
                    </svg>
                  </button>
                  <!---->
                  <div
                    x-cloak
                    x-show="openProfile"
                    x-transition:enter="transform transition ease-in-out duration-75"
                    x-transition:enter-start=" opacity-0"
                    x-transition:enter-end="opacity-100"
                    x-transition:leave="transform transition ease-in-out duration-75"
                    x-transition:leave-start="opacity-100"
                    x-transition:leave-end="opacity-0 "
                    class="p-4 text-sm text-gray-700 bg-gray-100"
                  >
                    <div class="space-y-3 divide-y divide-gray-200">
                      <div class="grid grid-cols-2 gap-3 pt-3">
                        <p class="font-medium">Customer</p>
                        <div class="flex items-center gap-3">
                          <p class="text-gray-800 text-sm font-medium p-1.5 rounded-full bg-white">
                            OR
                          </p>
                          <div class="text-sm">
                            <p class="font-medium text-gray-900">Larry Weya</p>
                            <p class="text-gray-500">Director</p>
                          </div>
                        </div>
                      </div>
                      <div class="grid justify-between grid-cols-2 gap-3 pt-3">
                        <p class="font-medium">About</p>
                        <div>
                          <p class="font-medium text-gray-900">Full Admin Access</p>
                          <p class="text-gray-500">
                            Can make applications, change particulars and manage users
                          </p>
                        </div>
                      </div>
                      <div class="flex justify-end pt-3">
                        <div class="flex items-center space-x-3">
                          <button class="font-semibold text-gray-800 transition-colors hover:text-gray-500">
                            Edit
                          </button>
                          <button class="font-semibold text-red-600 transition-colors hover:text-red-900">
                            Remove
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
