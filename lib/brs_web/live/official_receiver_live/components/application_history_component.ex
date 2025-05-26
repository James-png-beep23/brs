defmodule BrsWeb.OfficialReceiverLive.ApplicationHistoryComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <!-- table content -->
      <div class="flex flex-col mb-4">
        <div class="sm:overflow-auto lg:overflow-visible">
          <!-- Table Desktop -->
          <div class="hidden w-full align-middle sm:block">
            <div class="pb-4 shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0 rounded-lg divide-y divide-gray-200">
              <div class="bg-white px-4 py-3 flex space-x-3">
                <div class="flex-1">
                  <!-- search -->
                  <form class="w-full flex md:ml-0" action="#" method="GET">
                    <label for="search-field" class="sr-only">Search</label>
                    <div class="relative w-full text-gray-400 focus-within:text-gray-600 rounded-full bg-white">
                      <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
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
                        class="block w-full border rounded-lg border-gray-300 py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-1 focus:ring-offset-0 focus:ring-primary-600 sm:text-base sm:leading-5"
                        placeholder="Search"
                        type="search"
                        name="Search filed returns"
                      />
                    </div>
                  </form>
                </div>
                <button class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100 flex items-center space-x-2">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 20 20"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M5 10H15M2.5 5H17.5M7.5 15H12.5"
                      stroke="#344054"
                      stroke-width="1.66667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                  <span class="inline-block"> Apply Filter</span>
                </button>
              </div>

              <table class="min-w-full divide-y divide-gray-300 table-auto">
                <thead class="bg-gray-50">
                  <tr>
                    <th
                      scope="col"
                      class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-800 sm:pl-4 capitalize"
                    >
                      Application ID
                    </th>
                    <th
                      scope="col"
                      class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                    >
                      Application Name
                    </th>
                    <th
                      scope="col"
                      class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                    >
                      Status
                    </th>
                    <th
                      scope="col"
                      class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                    >
                      Submitted
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
                    <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-700 whitespace-nowrap sm:pl-4">
                      LPR-12320
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      Limited Partnership Registration
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-orange-700 ring-1 ring-inset ring-transparent">
                          <svg
                            class="h-1.5 w-1.5 fill-orange-400"
                            viewBox="0 0 6 6"
                            aria-hidden="true"
                          >
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Verification
                        </span>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      <div class="text-sm">
                        <p>Nicole Musundi</p>
                        <p>Dec 09, 2022. 6:12 am</p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-right text-sm text-gray-700 whitespace-nowrap">
                      <a
                        href="#"
                        class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100"
                      >
                        View
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-700 whitespace-nowrap sm:pl-4">
                      BNR-12320
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      Business Name Registration
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                          <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Complete
                        </span>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                      <div class="text-sm">
                        <p>Derrick Ogare</p>
                        <p>Dec 09, 2022. 6:12 am</p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-right text-sm text-gray-700 whitespace-nowrap">
                      <a
                        href="#"
                        class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100"
                      >
                        View
                      </a>
                    </td>
                  </tr>
                </tbody>
              </table>
              <nav
                class="flex items-center bg-white justify-between px-3 border-t border-gray-300 py-3"
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
          <!-- Table Mobile -->
          <div class="w-full sm:hidden bg-white rounded-lg">
            <div class="bg-white px-4 py-3 flex flex-col sm:flex-row gap-4 border-b border-gray-200">
              <div class="flex-1">
                <!-- search -->
                <form class="w-full flex md:ml-0" action="#" method="GET">
                  <label for="search-field" class="sr-only">Search</label>
                  <div class="relative w-full text-gray-400 focus-within:text-gray-600 rounded-full bg-white">
                    <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
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
                      class="block w-full border rounded-lg border-gray-300 py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-1 focus:ring-offset-0 focus:ring-primary-600 sm:text-base sm:leading-5"
                      placeholder="Search"
                      type="search"
                      name="Search filed returns"
                    />
                  </div>
                </form>
              </div>
              <button class="px-4 py-2 text-sm self-start font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100 flex items-center space-x-2">
                <svg
                  width="20"
                  height="20"
                  viewBox="0 0 20 20"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M5 10H15M2.5 5H17.5M7.5 15H12.5"
                    stroke="#344054"
                    stroke-width="1.66667"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
                <span class="inline-block"> Apply Filter</span>
              </button>
            </div>
            <div x-data="{openProfile: false}" class="w-full bg-white border-b border-gray-300">
              <div>
                <button
                  @click="openProfile = !openProfile"
                  type="button"
                  aria-expanded="false"
                  class="flex justify-between items-center w-full px-4 py-3 font-medium text-sm text-left focus:outline-none"
                >
                  <div>
                    <span class="text-gray-700 block pb-1">Application ID</span>
                    <span class="block text-gray-500">LPR-12320</span>
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
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Application ID</p>
                      <p class="">LPR-12320</p>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Application Name</p>
                      <p class="">Limited Partnership Registration</p>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Status</p>
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-orange-700 ring-1 ring-inset ring-transparent">
                          <svg
                            class="h-1.5 w-1.5 fill-orange-400"
                            viewBox="0 0 6 6"
                            aria-hidden="true"
                          >
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Verification
                        </span>
                      </div>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Submitted</p>
                      <div>
                        <p class="mb-1">Nicole Musundi</p>
                        <p>Dec 09, 2022. 6:12 am</p>
                      </div>
                    </div>
                    <div class="flex items-center justify-end pt-3 space-x-2">
                      <a
                        href="#"
                        class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100"
                      >
                        View
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div x-data="{openProfile: false}" class="w-full bg-white border-b border-gray-300">
              <div>
                <button
                  @click="openProfile = !openProfile"
                  type="button"
                  aria-expanded="false"
                  class="flex justify-between items-center w-full px-4 py-3 font-medium text-sm text-left focus:outline-none"
                >
                  <div>
                    <span class="text-gray-700 block pb-1">Application ID</span>
                    <span class="block text-gray-500">BNR-12320</span>
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
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Application ID</p>
                      <p class="">BNR-12320</p>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Application Name</p>
                      <p class="">Business Name Registration</p>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Status</p>
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                          <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Complete
                        </span>
                      </div>
                    </div>
                    <div class="flex items-center justify-between pt-3 space-x-2">
                      <p class="font-medium">Submitted</p>
                      <div>
                        <p class="mb-1">Derrick Ogare</p>
                        <p>Dec 09, 2022. 6:12 am</p>
                      </div>
                    </div>
                    <div class="flex items-center justify-end pt-3 space-x-2">
                      <a
                        href="#"
                        class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md focus:ring-2 focus:ring-primary-600 hover:bg-gray-100"
                      >
                        View
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
