defmodule BrsWeb.HirePurchaseLive.ApplicationHistoryComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div>
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
              class="block w-full rounded-full border border-gray-300 bg-white py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-400 focus:border-white focus:outline-none focus:ring-1 focus:ring-offset-1 focus:ring-gray-500 sm:text-sm"
              placeholder="Search"
              type="search"
              name="search"
            />
          </div>
        </form>
      </div>

      <div>
        <!-- table content -->
        <div class="flex flex-col mb-4">
          <div class="sm:overflow-auto lg:overflow-visible">
            <!-- Table Desktop -->
            <div class="hidden w-full align-middle sm:block">
              <div class="pb-4 shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0 rounded-lg divide-y divide-gray-200">
                <table class="min-w-full divide-y divide-gray-300 table-auto">
                  <thead class="bg-gray-50">
                    <tr>
                      <th
                        scope="col"
                        class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-600 sm:pl-4"
                      >
                        Application ID
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Application Name
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Amount
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
                    <tr>
                      <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                        <div>
                          <p class="text-sm font-medium text-gray-900">
                            PVT-20202
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Limited Partnership Registration
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
                            Verification
                          </span>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Andrew Kamala- Individual
                          </p>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022. 6:12 am
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                        <div class="inline-flex justify-end items-center space-x-3 text-right">
                          <a
                            href="./view-notice.html"
                            class="inline-flex items-center rounded-md border border-primary-500 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                          >
                            View
                          </a>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                        <div>
                          <p class="text-sm font-medium text-gray-900">
                            PVT-20202
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Limited Partnership Registration
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                            <svg
                              class="h-1.5 w-1.5 fill-green-400"
                              viewBox="0 0 6 6"
                              aria-hidden="true"
                            >
                              <circle cx="3" cy="3" r="3" />
                            </svg>
                            Complete
                          </span>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Mwiti Andrew
                          </p>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022. 6:12 am
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                        <div class="inline-flex justify-end items-center space-x-3 text-right">
                          <a
                            href="./view-notice.html"
                            class="inline-flex items-center rounded-md border border-primary-500 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                          >
                            View
                          </a>
                        </div>
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
            <!-- Mobile table -->
            <div class="divide-y divide-gray-300 shadow bg-white block sm:hidden rounded-lg overflow-hidden">
              <div x-data="{openCard: false}" class="mx-auto w-full p-3">
                <button
                  id="headlessui-disclosure-button-118"
                  type="button"
                  aria-expanded="true"
                  class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                  aria-controls="headlessui-disclosure-panel-119"
                >
                  <div>
                    <p class="text-sm font-medium text-gray-900 mb-2">Application ID</p>
                    <p class="text-sm font-medium text-gray-700">PVT-20202</p>
                  </div>
                  <span
                    @click="openCard = !openCard"
                    class="inline-block p-0.5 border rounded-md border-gray-400"
                  >
                    <svg
                      class="openCard ? 'rotate-0 transform' : 'rotate-180 transform'"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke-width="2"
                      stroke="currentColor"
                      aria-hidden="true"
                      class="h-5 w-5 text-gray-500"
                    >
                      <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7"></path>
                    </svg>
                  </span>
                </button>
                <div
                  x-cloak
                  x-show="openCard"
                  x-transition:enter="transform transition ease-in-out duration-75"
                  x-transition:enter-start=" opacity-0"
                  x-transition:enter-end="opacity-100"
                  x-transition:leave="transform transition ease-in-out duration-75"
                  x-transition:leave-start="opacity-100"
                  x-transition:leave-end="opacity-0"
                  id="headlessui-disclosure-panel-119"
                >
                  <div class="border-t mt-4 pt-4 grid grid-cols-1 gap-3">
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Application ID</p>
                      <p class="text-sm font-normal text-gray-900">PVT-20202</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Application Name</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Limited Partnership Registration
                        </p>
                      </div>
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
                          Verification
                        </span>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Amount</p>
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Mwiti Andrew
                        </p>
                        <p class="text-sm font-normal text-gray-500">
                          Dec 09, 2022. 6:12 am
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                    <a
                      href="./view-notice.html"
                      class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                    >
                      View
                    </a>
                  </div>
                </div>
              </div>
              <div x-data="{openCard: false}" class="mx-auto w-full p-3">
                <button
                  id="headlessui-disclosure-button-118"
                  type="button"
                  aria-expanded="true"
                  class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                  aria-controls="headlessui-disclosure-panel-119"
                >
                  <div>
                    <p class="text-sm font-medium text-gray-900 mb-2">Application ID</p>
                    <p class="text-sm font-medium text-gray-700">PVT-20202</p>
                  </div>
                  <span
                    @click="openCard = !openCard"
                    class="inline-block p-0.5 border rounded-md border-gray-400"
                  >
                    <svg
                      class="openCard ? 'rotate-0 transform' : 'rotate-180 transform'"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke-width="2"
                      stroke="currentColor"
                      aria-hidden="true"
                      class="h-5 w-5 text-gray-500"
                    >
                      <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7"></path>
                    </svg>
                  </span>
                </button>
                <div
                  x-cloak
                  x-show="openCard"
                  x-transition:enter="transform transition ease-in-out duration-75"
                  x-transition:enter-start=" opacity-0"
                  x-transition:enter-end="opacity-100"
                  x-transition:leave="transform transition ease-in-out duration-75"
                  x-transition:leave-start="opacity-100"
                  x-transition:leave-end="opacity-0"
                  id="headlessui-disclosure-panel-119"
                >
                  <div class="border-t mt-4 pt-4 grid grid-cols-1 gap-3">
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Application ID</p>
                      <p class="text-sm font-normal text-gray-900">PVT-20202</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Application Name</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Limited Partnership Registration
                        </p>
                      </div>
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
                          Verification
                        </span>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Amount</p>
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Mwiti Andrew
                        </p>
                        <p class="text-sm font-normal text-gray-500">
                          Dec 09, 2022. 6:12 am
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                    <a
                      href="./view-notice.html"
                      class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                    >
                      View
                    </a>
                  </div>
                </div>
              </div>
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
        </div>
      </div>
    </div>
    """
  end
end
