defmodule BrsWeb.StaffLive.CompletedTaskComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div>
        <div class="px-4 py-2 bg-white rounded-full inline-flex justify-start items-center space-x-3">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="18"
            height="18"
            viewBox="0 0 18 18"
            fill="none"
          >
            <path
              d="M9 0.875C7.39303 0.875 5.82214 1.35152 4.486 2.24431C3.14985 3.1371 2.10844 4.40605 1.49348 5.8907C0.87852 7.37535 0.717618 9.00901 1.03112 10.5851C1.34463 12.1612 2.11846 13.6089 3.25476 14.7452C4.39106 15.8815 5.8388 16.6554 7.4149 16.9689C8.99099 17.2824 10.6247 17.1215 12.1093 16.5065C13.594 15.8916 14.8629 14.8502 15.7557 13.514C16.6485 12.1779 17.125 10.607 17.125 9C17.1227 6.84581 16.266 4.78051 14.7427 3.25727C13.2195 1.73403 11.1542 0.877275 9 0.875ZM9 15.875C7.64026 15.875 6.31105 15.4718 5.18046 14.7164C4.04987 13.9609 3.16868 12.8872 2.64833 11.6309C2.12798 10.3747 1.99183 8.99237 2.2571 7.65875C2.52238 6.32513 3.17716 5.10013 4.13864 4.13864C5.10013 3.17716 6.32514 2.52237 7.65876 2.2571C8.99238 1.99183 10.3747 2.12798 11.631 2.64833C12.8872 3.16868 13.9609 4.04987 14.7164 5.18045C15.4718 6.31104 15.875 7.64025 15.875 9C15.8729 10.8227 15.1479 12.5702 13.8591 13.8591C12.5702 15.1479 10.8227 15.8729 9 15.875ZM10.25 12.75C10.25 12.9158 10.1842 13.0747 10.0669 13.1919C9.94974 13.3092 9.79076 13.375 9.625 13.375C9.29348 13.375 8.97554 13.2433 8.74112 13.0089C8.5067 12.7745 8.375 12.4565 8.375 12.125V9C8.20924 9 8.05027 8.93415 7.93306 8.81694C7.81585 8.69973 7.75 8.54076 7.75 8.375C7.75 8.20924 7.81585 8.05027 7.93306 7.93306C8.05027 7.81585 8.20924 7.75 8.375 7.75C8.70652 7.75 9.02447 7.8817 9.25889 8.11612C9.49331 8.35054 9.625 8.66848 9.625 9V12.125C9.79076 12.125 9.94974 12.1908 10.0669 12.3081C10.1842 12.4253 10.25 12.5842 10.25 12.75ZM7.75 5.5625C7.75 5.37708 7.80499 5.19582 7.908 5.04165C8.01101 4.88748 8.15743 4.76732 8.32874 4.69636C8.50004 4.62541 8.68854 4.60684 8.8704 4.64301C9.05226 4.67919 9.2193 4.76848 9.35042 4.89959C9.48153 5.0307 9.57082 5.19775 9.60699 5.3796C9.64316 5.56146 9.6246 5.74996 9.55364 5.92127C9.48268 6.09257 9.36252 6.23899 9.20835 6.342C9.05418 6.44502 8.87292 6.5 8.6875 6.5C8.43886 6.5 8.20041 6.40123 8.02459 6.22541C7.84878 6.0496 7.75 5.81114 7.75 5.5625Z"
              fill="#344054"
            />
          </svg>

          <p class="text-sm sm:text-base font-medium text-gray-700">
            Only showing recent tasks
          </p>
        </div>
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
                        Task name
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Application Number
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Date Assigned
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Date Completed
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-sm font-medium text-gray-600 text-right">
                        &nbsp;
                      </th>
                    </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-gray-200">
                    <tr>
                      <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                        <div>
                          <p class="text-sm font-medium text-gray-900">
                            Name Reservation
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            NR-90GH8
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022.
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022.
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                        <div class="inline-flex justify-end items-center space-x-3 text-right">
                          <a
                            href={~p"/admin/registries/brs/applications/1"}
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
                            Business Registration Initial Review
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            NR-90GH8
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022.
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Dec 09, 2022.
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                        <div class="inline-flex justify-end items-center space-x-3 text-right">
                          <a
                            href={~p"/admin/registries/brs/applications/1"}
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
                  class="flex items-center bg-white justify-between px-3  pr-4 sm:pr-6 border-t border-gray-300 py-3"
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
            <div class="divide-y divide-gray-300 shadow bg-white block sm:hidden rounded-lg">
              <div x-data="{openCard: false}" class="mx-auto w-full p-3">
                <button
                  id="headlessui-disclosure-button-118"
                  type="button"
                  aria-expanded="true"
                  class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                  aria-controls="headlessui-disclosure-panel-119"
                >
                  <div>
                    <p class="text-sm font-medium text-gray-900 mb-2">Task Name</p>
                    <p class="text-sm font-medium text-gray-700">
                      Business Registration Initial Review
                    </p>
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
                      <p class="text-xs text-gray-600">Application Number</p>
                      <p class="text-sm font-normal text-gray-900">NR-90GH8</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Date Assigned</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022.
                        </p>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Date Completed</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022.
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                    <a
                      href={~p"/admin/registries/brs/applications/1"}
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
                    <p class="text-sm font-medium text-gray-900 mb-2">Task Name</p>
                    <p class="text-sm font-medium text-gray-700">
                      Business Registration Initial Review
                    </p>
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
                      <p class="text-xs text-gray-600">Application Number</p>
                      <p class="text-sm font-normal text-gray-900">NR-90GH8</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Date Assigned</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022.
                        </p>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Date Completed</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022.
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                    <a
                      href={~p"/admin/registries/brs/applications/1"}
                      class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
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
    """
  end
end
