defmodule BrsWeb.CompanyLive.Tabs.AnnualReturnsComponent do
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
                        placeholder="Search filed returns"
                        type="search"
                        name="Search filed returns"
                      />
                    </div>
                  </form>
                </div>

                <table class="min-w-full divide-y divide-gray-300 table-auto">
                  <thead class="bg-gray-50">
                    <tr>
                      <th
                        scope="col"
                        class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-800 sm:pl-4 capitalize"
                      >
                        #
                      </th>
                      <th
                        scope="col"
                        class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                      >
                        Year
                      </th>
                      <th
                        scope="col"
                        class="px-3 py-2.5 text-left text-sm font-medium text-gray-800 capitalize"
                      >
                        Date Submitted
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
                        1
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        2019 - 2020
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        December, 09 2022 6:12 am
                      </td>
                      <td class="px-3 py-4 text-sm text-right text-gray-700 whitespace-nowrap">
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
                        2
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        2019 - 2020
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-700 whitespace-nowrap">
                        December, 09 2022 6:12 am
                      </td>
                      <td class="px-3 py-4 text-sm text-right text-gray-700 whitespace-nowrap">
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
                  class="flex items-center justify-between px-3 py-3 bg-white border-t border-gray-300"
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
            <div class="w-full bg-white rounded-lg sm:hidden">
              <div class="px-4 py-3 bg-white border-b border-gray-200">
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

              <div x-data="{openProfile: false}" class="w-full bg-white border-b border-gray-300">
                <div>
                  <button
                    @click="openProfile = !openProfile"
                    type="button"
                    aria-expanded="false"
                    class="flex items-center justify-between w-full px-4 py-3 text-sm font-medium text-left focus:outline-none"
                  >
                    <span class="text-gray-700">2019 - 2020</span>
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
                        <p class="font-medium">#</p>
                        <p class="">1</p>
                      </div>
                      <div class="flex items-center justify-between pt-3 space-x-2">
                        <p class="font-medium">Year</p>
                        <p class="">2019 - 2020</p>
                      </div>
                      <div class="flex items-center justify-between pt-3 space-x-2">
                        <p class="font-medium">Date Submitted</p>
                        <p class="">December, 09 2022 6:12 am</p>
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
                    class="flex items-center justify-between w-full px-4 py-3 text-sm font-medium text-left focus:outline-none"
                  >
                    <span class="text-gray-700">2018 -2019</span>
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
                        <p class="font-medium">#</p>
                        <p class="">2</p>
                      </div>
                      <div class="flex items-center justify-between pt-3 space-x-2">
                        <p class="font-medium">Year</p>
                        <p class="">2018 -2019</p>
                      </div>
                      <div class="flex items-center justify-between pt-3 space-x-2">
                        <p class="font-medium">Date Submitted</p>
                        <p class="">December, 09 2022 6:12 am</p>
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
    </section>
    """
  end
end
