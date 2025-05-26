defmodule BrsWeb.CompanyLive.Tabs.BusinessesComponent do
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
      <!-- table content -->
      <div class="flex flex-col mb-4">
        <div class="sm:overflow-auto lg:overflow-visible">
          <!-- Table Desktop -->
          <div class="hidden w-full align-middle sm:block">
            <div class="pb-4 divide-y divide-gray-200 rounded-lg shadow sm:overflow-x-auto ring-1 ring-black ring-opacity-5 sm:pb-0">
              <div class="flex px-4 py-3 space-x-4 bg-white">
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
                      class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-600"
                    >
                      Company
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Date Registered
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Company Type
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Status
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      B.O Status
                    </th>
                    <th
                      scope="col"
                      class="px-3 py-2.5 pr-4 text-sm font-medium text-gray-600 text-right"
                    >
                      Action
                    </th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <tr>
                    <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500">
                      <div>
                        <div class="flex items-center space-x-2">
                          <p class="text-sm font-medium text-blue-600">
                            C.8/2002
                          </p>
                        </div>

                        <p class="text-sm font-medium text-gray-900">
                          Nikki Creditors Association
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Dec 09, 2022
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Public Limited Company
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                          <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Active
                        </span>
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
                    <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                      <div class="inline-flex items-center justify-end space-x-3 text-right">
                        <a
                          href="#"
                          type="button"
                          class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                        >
                          View
                        </a>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td class="px-3 py-4 pl-4 pr-3 text-sm font-medium text-gray-500">
                      <div>
                        <div class="flex items-center space-x-2">
                          <p class="text-sm font-medium text-blue-600">
                            C.8/2002
                          </p>
                          <svg
                            width="16"
                            height="16"
                            viewBox="0 0 16 16"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              fill-rule="evenodd"
                              clip-rule="evenodd"
                              d="M4.26698 1.45486C4.91024 1.4035 5.52089 1.15049 6.01198 0.73186C6.56664 0.259451 7.27141 0 7.99998 0C8.72856 0 9.43332 0.259451 9.98798 0.73186C10.4791 1.15049 11.0897 1.4035 11.733 1.45486C12.4594 1.51292 13.1414 1.82782 13.6567 2.34313C14.172 2.85843 14.4869 3.54043 14.545 4.26686C14.596 4.90986 14.849 5.52086 15.268 6.01186C15.7404 6.56652 15.9998 7.27129 15.9998 7.99986C15.9998 8.72843 15.7404 9.4332 15.268 9.98786C14.8493 10.4789 14.5963 11.0896 14.545 11.7329C14.4869 12.4593 14.172 13.1413 13.6567 13.6566C13.1414 14.1719 12.4594 14.4868 11.733 14.5449C11.0897 14.5962 10.4791 14.8492 9.98798 15.2679C9.43332 15.7403 8.72856 15.9997 7.99998 15.9997C7.27141 15.9997 6.56664 15.7403 6.01198 15.2679C5.52089 14.8492 4.91024 14.5962 4.26698 14.5449C3.54055 14.4868 2.85855 14.1719 2.34325 13.6566C1.82794 13.1413 1.51304 12.4593 1.45498 11.7329C1.40362 11.0896 1.15061 10.4789 0.731982 9.98786C0.259573 9.4332 0.00012207 8.72843 0.00012207 7.99986C0.00012207 7.27129 0.259573 6.56652 0.731982 6.01186C1.15061 5.52077 1.40362 4.91012 1.45498 4.26686C1.51304 3.54043 1.82794 2.85843 2.34325 2.34313C2.85855 1.82782 3.54055 1.51292 4.26698 1.45486ZM11.707 6.70686C11.8891 6.51826 11.9899 6.26566 11.9877 6.00346C11.9854 5.74126 11.8802 5.49045 11.6948 5.30504C11.5094 5.11963 11.2586 5.01446 10.9964 5.01219C10.7342 5.00991 10.4816 5.1107 10.293 5.29286L6.99998 8.58586L5.70698 7.29286C5.51838 7.1107 5.26578 7.00991 5.00358 7.01219C4.74138 7.01446 4.49057 7.11963 4.30516 7.30504C4.11976 7.49045 4.01459 7.74126 4.01231 8.00346C4.01003 8.26566 4.11082 8.51826 4.29298 8.70686L6.29298 10.7069C6.48051 10.8943 6.73482 10.9996 6.99998 10.9996C7.26515 10.9996 7.51945 10.8943 7.70698 10.7069L11.707 6.70686Z"
                              fill="#0066FF"
                            />
                          </svg>
                        </div>

                        <p class="text-sm font-medium text-gray-900">
                          Nikki Creditors Association
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Dec 09, 2022
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <p class="text-sm font-normal text-gray-500">
                          Public Limited Company
                        </p>
                      </div>
                    </td>
                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                          <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Active
                        </span>
                      </div>
                    </td>

                    <td class="px-3 py-4 text-sm text-gray-500">
                      <div>
                        <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                          <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                            <circle cx="3" cy="3" r="3" />
                          </svg>
                          Complete
                        </span>
                      </div>
                    </td>
                    <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                      <div class="inline-flex items-center justify-end space-x-3 text-right">
                        <a
                          href="#"
                          type="button"
                          class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                        >
                          View
                        </a>
                      </div>
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
          <!-- Mobile table -->
          <div class="block divide-y divide-gray-300 sm:hidden">
            <div class="flex flex-col gap-4 px-4 py-3 bg-white border-b border-gray-200 sm:flex-row">
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
            <div x-data="{openCard: false}" class="block w-full p-3 mx-auto bg-white sm:hidden">
              <button
                id="headlessui-disclosure-button-118"
                type="button"
                aria-expanded="true"
                class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                aria-controls="headlessui-disclosure-panel-119"
              >
                <div>
                  <p class="text-base font-medium text-gray-900">Company</p>
                  <p class="text-sm font-medium text-gray-700">Nikki Creditors Association</p>
                  <div class="flex items-center space-x-2">
                    <p class="text-sm font-medium text-blue-600">
                      C.8/2002
                    </p>
                  </div>
                </div>
                <span
                  @click="openCard = !openCard"
                  class="inline-block p-0.5 border rounded-md border-gray-400"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                    stroke="currentColor"
                    aria-hidden="true"
                    class="w-5 h-5 text-gray-500"
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
                <div class="grid grid-cols-2 gap-4 pt-4 mt-4 border-t">
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Company</p>
                    <p class="text-sm font-medium">Nikki Creditors Association</p>
                    <div class="flex items-center space-x-2">
                      <p class="text-sm font-medium text-blue-600">
                        C.8/2002
                      </p>
                    </div>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Date Registered</p>
                    <p class="text-sm font-medium">Dec 09, 2022</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Company Type</p>
                    <p class="text-sm font-medium">Public Limited Company</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Status</p>
                    <div>
                      <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                        <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                          <circle cx="3" cy="3" r="3" />
                        </svg>
                        Active
                      </span>
                    </div>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">B.O Status</p>
                    <div>
                      <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-orange-700 ring-1 ring-inset ring-transparent">
                        <svg class="h-1.5 w-1.5 fill-orange-400" viewBox="0 0 6 6" aria-hidden="true">
                          <circle cx="3" cy="3" r="3" />
                        </svg>
                        Verification
                      </span>
                    </div>
                  </div>
                </div>
                <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                  <a
                    href="#"
                    class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                  >
                    View
                  </a>
                </div>
              </div>
            </div>
            <div x-data="{openCard: false}" class="block w-full p-3 mx-auto bg-white sm:hidden">
              <button
                id="headlessui-disclosure-button-118"
                type="button"
                aria-expanded="true"
                class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                aria-controls="headlessui-disclosure-panel-119"
              >
                <div>
                  <p class="text-base font-medium text-gray-900">Company</p>
                  <p class="text-sm font-medium text-gray-700">Nikki Creditors Association</p>
                  <div class="flex items-center space-x-2">
                    <p class="text-sm font-medium text-blue-600">
                      C.8/2002
                    </p>
                    <svg
                      width="16"
                      height="16"
                      viewBox="0 0 16 16"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M4.26698 1.45486C4.91024 1.4035 5.52089 1.15049 6.01198 0.73186C6.56664 0.259451 7.27141 0 7.99998 0C8.72856 0 9.43332 0.259451 9.98798 0.73186C10.4791 1.15049 11.0897 1.4035 11.733 1.45486C12.4594 1.51292 13.1414 1.82782 13.6567 2.34313C14.172 2.85843 14.4869 3.54043 14.545 4.26686C14.596 4.90986 14.849 5.52086 15.268 6.01186C15.7404 6.56652 15.9998 7.27129 15.9998 7.99986C15.9998 8.72843 15.7404 9.4332 15.268 9.98786C14.8493 10.4789 14.5963 11.0896 14.545 11.7329C14.4869 12.4593 14.172 13.1413 13.6567 13.6566C13.1414 14.1719 12.4594 14.4868 11.733 14.5449C11.0897 14.5962 10.4791 14.8492 9.98798 15.2679C9.43332 15.7403 8.72856 15.9997 7.99998 15.9997C7.27141 15.9997 6.56664 15.7403 6.01198 15.2679C5.52089 14.8492 4.91024 14.5962 4.26698 14.5449C3.54055 14.4868 2.85855 14.1719 2.34325 13.6566C1.82794 13.1413 1.51304 12.4593 1.45498 11.7329C1.40362 11.0896 1.15061 10.4789 0.731982 9.98786C0.259573 9.4332 0.00012207 8.72843 0.00012207 7.99986C0.00012207 7.27129 0.259573 6.56652 0.731982 6.01186C1.15061 5.52077 1.40362 4.91012 1.45498 4.26686C1.51304 3.54043 1.82794 2.85843 2.34325 2.34313C2.85855 1.82782 3.54055 1.51292 4.26698 1.45486ZM11.707 6.70686C11.8891 6.51826 11.9899 6.26566 11.9877 6.00346C11.9854 5.74126 11.8802 5.49045 11.6948 5.30504C11.5094 5.11963 11.2586 5.01446 10.9964 5.01219C10.7342 5.00991 10.4816 5.1107 10.293 5.29286L6.99998 8.58586L5.70698 7.29286C5.51838 7.1107 5.26578 7.00991 5.00358 7.01219C4.74138 7.01446 4.49057 7.11963 4.30516 7.30504C4.11976 7.49045 4.01459 7.74126 4.01231 8.00346C4.01003 8.26566 4.11082 8.51826 4.29298 8.70686L6.29298 10.7069C6.48051 10.8943 6.73482 10.9996 6.99998 10.9996C7.26515 10.9996 7.51945 10.8943 7.70698 10.7069L11.707 6.70686Z"
                        fill="#0066FF"
                      />
                    </svg>
                  </div>
                </div>
                <span
                  @click="openCard = !openCard"
                  class="inline-block p-0.5 border rounded-md border-gray-400"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                    stroke="currentColor"
                    aria-hidden="true"
                    class="w-5 h-5 text-gray-500"
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
                <div class="grid grid-cols-2 gap-4 pt-4 mt-4 border-t">
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Company</p>
                    <p class="text-sm font-medium">Nikki Creditors Association</p>
                    <div class="flex items-center space-x-2">
                      <p class="text-sm font-medium text-blue-600">
                        C.8/2002
                      </p>
                      <svg
                        width="16"
                        height="16"
                        viewBox="0 0 16 16"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M4.26698 1.45486C4.91024 1.4035 5.52089 1.15049 6.01198 0.73186C6.56664 0.259451 7.27141 0 7.99998 0C8.72856 0 9.43332 0.259451 9.98798 0.73186C10.4791 1.15049 11.0897 1.4035 11.733 1.45486C12.4594 1.51292 13.1414 1.82782 13.6567 2.34313C14.172 2.85843 14.4869 3.54043 14.545 4.26686C14.596 4.90986 14.849 5.52086 15.268 6.01186C15.7404 6.56652 15.9998 7.27129 15.9998 7.99986C15.9998 8.72843 15.7404 9.4332 15.268 9.98786C14.8493 10.4789 14.5963 11.0896 14.545 11.7329C14.4869 12.4593 14.172 13.1413 13.6567 13.6566C13.1414 14.1719 12.4594 14.4868 11.733 14.5449C11.0897 14.5962 10.4791 14.8492 9.98798 15.2679C9.43332 15.7403 8.72856 15.9997 7.99998 15.9997C7.27141 15.9997 6.56664 15.7403 6.01198 15.2679C5.52089 14.8492 4.91024 14.5962 4.26698 14.5449C3.54055 14.4868 2.85855 14.1719 2.34325 13.6566C1.82794 13.1413 1.51304 12.4593 1.45498 11.7329C1.40362 11.0896 1.15061 10.4789 0.731982 9.98786C0.259573 9.4332 0.00012207 8.72843 0.00012207 7.99986C0.00012207 7.27129 0.259573 6.56652 0.731982 6.01186C1.15061 5.52077 1.40362 4.91012 1.45498 4.26686C1.51304 3.54043 1.82794 2.85843 2.34325 2.34313C2.85855 1.82782 3.54055 1.51292 4.26698 1.45486ZM11.707 6.70686C11.8891 6.51826 11.9899 6.26566 11.9877 6.00346C11.9854 5.74126 11.8802 5.49045 11.6948 5.30504C11.5094 5.11963 11.2586 5.01446 10.9964 5.01219C10.7342 5.00991 10.4816 5.1107 10.293 5.29286L6.99998 8.58586L5.70698 7.29286C5.51838 7.1107 5.26578 7.00991 5.00358 7.01219C4.74138 7.01446 4.49057 7.11963 4.30516 7.30504C4.11976 7.49045 4.01459 7.74126 4.01231 8.00346C4.01003 8.26566 4.11082 8.51826 4.29298 8.70686L6.29298 10.7069C6.48051 10.8943 6.73482 10.9996 6.99998 10.9996C7.26515 10.9996 7.51945 10.8943 7.70698 10.7069L11.707 6.70686Z"
                          fill="#0066FF"
                        />
                      </svg>
                    </div>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Date Registered</p>
                    <p class="text-sm font-medium">Dec 09, 2022</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Company Type</p>
                    <p class="text-sm font-medium">Public Limited Company</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Status</p>
                    <div>
                      <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                        <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                          <circle cx="3" cy="3" r="3" />
                        </svg>
                        Active
                      </span>
                    </div>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">B.O Status</p>
                    <div>
                      <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-transparent">
                        <svg class="h-1.5 w-1.5 fill-green-400" viewBox="0 0 6 6" aria-hidden="true">
                          <circle cx="3" cy="3" r="3" />
                        </svg>
                        Complete
                      </span>
                    </div>
                  </div>
                </div>
                <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                  <a
                    href="#"
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
    </section>
    """
  end
end
