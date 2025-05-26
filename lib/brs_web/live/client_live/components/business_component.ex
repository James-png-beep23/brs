defmodule BrsWeb.ClientLive.BusinessComponent do
  use BrsWeb, :live_component

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
                      class="py-2.5 pl-4 pr-3 text-left text-sm font-medium text-gray-600 sm:pl-6"
                    >
                      Name
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Date Registered
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Company Type
                    </th>
                    <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                      Association
                    </th>
                    <th
                      scope="col"
                      class="px-3 py-2.5 text-left text-sm font-medium text-gray-600 text-right"
                    >
                      Action
                    </th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <tr>
                    <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-6">
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
                        <p class="text-sm font-normal text-gray-500">
                          Director shareholder
                        </p>
                      </div>
                    </td>
                    <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                      <div class="inline-flex justify-end items-center space-x-3 text-right">
                        <button
                          type="button"
                          class="inline-flex items-center rounded-md border border-primary-500 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                        >
                          View
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-6">
                      <div>
                        <div class="flex items-center space-x-2">
                          <p class="text-sm font-medium text-blue-600">
                            C.8/2002
                          </p>
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="16"
                            height="16"
                            viewBox="0 0 16 16"
                            fill="none"
                          >
                            <path
                              fill-rule="evenodd"
                              clip-rule="evenodd"
                              d="M4.26686 1.45486C4.91012 1.4035 5.52077 1.15049 6.01186 0.73186C6.56652 0.259451 7.27129 0 7.99986 0C8.72843 0 9.4332 0.259451 9.98786 0.73186C10.4789 1.15049 11.0896 1.4035 11.7329 1.45486C12.4593 1.51292 13.1413 1.82782 13.6566 2.34313C14.1719 2.85843 14.4868 3.54043 14.5449 4.26686C14.5959 4.90986 14.8489 5.52086 15.2679 6.01186C15.7403 6.56652 15.9997 7.27129 15.9997 7.99986C15.9997 8.72843 15.7403 9.4332 15.2679 9.98786C14.8492 10.4789 14.5962 11.0896 14.5449 11.7329C14.4868 12.4593 14.1719 13.1413 13.6566 13.6566C13.1413 14.1719 12.4593 14.4868 11.7329 14.5449C11.0896 14.5962 10.4789 14.8492 9.98786 15.2679C9.4332 15.7403 8.72843 15.9997 7.99986 15.9997C7.27129 15.9997 6.56652 15.7403 6.01186 15.2679C5.52077 14.8492 4.91012 14.5962 4.26686 14.5449C3.54043 14.4868 2.85843 14.1719 2.34313 13.6566C1.82782 13.1413 1.51292 12.4593 1.45486 11.7329C1.4035 11.0896 1.15049 10.4789 0.73186 9.98786C0.259451 9.4332 0 8.72843 0 7.99986C0 7.27129 0.259451 6.56652 0.73186 6.01186C1.15049 5.52077 1.4035 4.91012 1.45486 4.26686C1.51292 3.54043 1.82782 2.85843 2.34313 2.34313C2.85843 1.82782 3.54043 1.51292 4.26686 1.45486ZM11.7069 6.70686C11.889 6.51826 11.9898 6.26566 11.9875 6.00346C11.9853 5.74126 11.8801 5.49045 11.6947 5.30504C11.5093 5.11963 11.2585 5.01446 10.9963 5.01219C10.7341 5.00991 10.4815 5.1107 10.2929 5.29286L6.99986 8.58586L5.70686 7.29286C5.51826 7.1107 5.26565 7.00991 5.00346 7.01219C4.74126 7.01446 4.49045 7.11963 4.30504 7.30504C4.11963 7.49045 4.01446 7.74126 4.01219 8.00346C4.00991 8.26566 4.1107 8.51826 4.29286 8.70686L6.29286 10.7069C6.48039 10.8943 6.7347 10.9996 6.99986 10.9996C7.26502 10.9996 7.51933 10.8943 7.70686 10.7069L11.7069 6.70686Z"
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
                        <p class="text-sm font-normal text-gray-500">
                          Proprietor
                        </p>
                      </div>
                    </td>
                    <td class="px-4 py-4 text-sm text-gray-500 whitespace-nowrap text-right">
                      <div class="inline-flex justify-end items-center space-x-3 text-right">
                        <button
                          type="button"
                          class="inline-flex items-center rounded-md border border-primary-500 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                        >
                          View
                        </button>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <!-- Mobile table -->
          <div class="divide-y divide-gray-300">
            <div x-data="{openCard: false}" class="block sm:hidden mx-auto w-full bg-white p-3">
              <button
                id="headlessui-disclosure-button-118"
                type="button"
                aria-expanded="true"
                class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                aria-controls="headlessui-disclosure-panel-119"
              >
                <div>
                  <p class="text-base font-medium text-gray-900">Name</p>
                  <p class="text-sm font-medium text-gray-700">Nikki Creditors Association</p>
                  <div class="flex items-center space-x-2">
                    <p class="text-sm font-medium text-blue-600">
                      C.8/2002
                    </p>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      viewBox="0 0 16 16"
                      fill="none"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M4.26686 1.45486C4.91012 1.4035 5.52077 1.15049 6.01186 0.73186C6.56652 0.259451 7.27129 0 7.99986 0C8.72843 0 9.4332 0.259451 9.98786 0.73186C10.4789 1.15049 11.0896 1.4035 11.7329 1.45486C12.4593 1.51292 13.1413 1.82782 13.6566 2.34313C14.1719 2.85843 14.4868 3.54043 14.5449 4.26686C14.5959 4.90986 14.8489 5.52086 15.2679 6.01186C15.7403 6.56652 15.9997 7.27129 15.9997 7.99986C15.9997 8.72843 15.7403 9.4332 15.2679 9.98786C14.8492 10.4789 14.5962 11.0896 14.5449 11.7329C14.4868 12.4593 14.1719 13.1413 13.6566 13.6566C13.1413 14.1719 12.4593 14.4868 11.7329 14.5449C11.0896 14.5962 10.4789 14.8492 9.98786 15.2679C9.4332 15.7403 8.72843 15.9997 7.99986 15.9997C7.27129 15.9997 6.56652 15.7403 6.01186 15.2679C5.52077 14.8492 4.91012 14.5962 4.26686 14.5449C3.54043 14.4868 2.85843 14.1719 2.34313 13.6566C1.82782 13.1413 1.51292 12.4593 1.45486 11.7329C1.4035 11.0896 1.15049 10.4789 0.73186 9.98786C0.259451 9.4332 0 8.72843 0 7.99986C0 7.27129 0.259451 6.56652 0.73186 6.01186C1.15049 5.52077 1.4035 4.91012 1.45486 4.26686C1.51292 3.54043 1.82782 2.85843 2.34313 2.34313C2.85843 1.82782 3.54043 1.51292 4.26686 1.45486ZM11.7069 6.70686C11.889 6.51826 11.9898 6.26566 11.9875 6.00346C11.9853 5.74126 11.8801 5.49045 11.6947 5.30504C11.5093 5.11963 11.2585 5.01446 10.9963 5.01219C10.7341 5.00991 10.4815 5.1107 10.2929 5.29286L6.99986 8.58586L5.70686 7.29286C5.51826 7.1107 5.26565 7.00991 5.00346 7.01219C4.74126 7.01446 4.49045 7.11963 4.30504 7.30504C4.11963 7.49045 4.01446 7.74126 4.01219 8.00346C4.00991 8.26566 4.1107 8.51826 4.29286 8.70686L6.29286 10.7069C6.48039 10.8943 6.7347 10.9996 6.99986 10.9996C7.26502 10.9996 7.51933 10.8943 7.70686 10.7069L11.7069 6.70686Z"
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
                <div class="border-t mt-4 pt-4 grid grid-cols-2 gap-4">
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Name</p>
                    <p class="text-sm font-medium">Nikki Creditors Association</p>
                    <div class="flex items-center space-x-2">
                      <p class="text-sm font-medium text-blue-600">
                        C.8/2002
                      </p>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 16 16"
                        fill="none"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M4.26686 1.45486C4.91012 1.4035 5.52077 1.15049 6.01186 0.73186C6.56652 0.259451 7.27129 0 7.99986 0C8.72843 0 9.4332 0.259451 9.98786 0.73186C10.4789 1.15049 11.0896 1.4035 11.7329 1.45486C12.4593 1.51292 13.1413 1.82782 13.6566 2.34313C14.1719 2.85843 14.4868 3.54043 14.5449 4.26686C14.5959 4.90986 14.8489 5.52086 15.2679 6.01186C15.7403 6.56652 15.9997 7.27129 15.9997 7.99986C15.9997 8.72843 15.7403 9.4332 15.2679 9.98786C14.8492 10.4789 14.5962 11.0896 14.5449 11.7329C14.4868 12.4593 14.1719 13.1413 13.6566 13.6566C13.1413 14.1719 12.4593 14.4868 11.7329 14.5449C11.0896 14.5962 10.4789 14.8492 9.98786 15.2679C9.4332 15.7403 8.72843 15.9997 7.99986 15.9997C7.27129 15.9997 6.56652 15.7403 6.01186 15.2679C5.52077 14.8492 4.91012 14.5962 4.26686 14.5449C3.54043 14.4868 2.85843 14.1719 2.34313 13.6566C1.82782 13.1413 1.51292 12.4593 1.45486 11.7329C1.4035 11.0896 1.15049 10.4789 0.73186 9.98786C0.259451 9.4332 0 8.72843 0 7.99986C0 7.27129 0.259451 6.56652 0.73186 6.01186C1.15049 5.52077 1.4035 4.91012 1.45486 4.26686C1.51292 3.54043 1.82782 2.85843 2.34313 2.34313C2.85843 1.82782 3.54043 1.51292 4.26686 1.45486ZM11.7069 6.70686C11.889 6.51826 11.9898 6.26566 11.9875 6.00346C11.9853 5.74126 11.8801 5.49045 11.6947 5.30504C11.5093 5.11963 11.2585 5.01446 10.9963 5.01219C10.7341 5.00991 10.4815 5.1107 10.2929 5.29286L6.99986 8.58586L5.70686 7.29286C5.51826 7.1107 5.26565 7.00991 5.00346 7.01219C4.74126 7.01446 4.49045 7.11963 4.30504 7.30504C4.11963 7.49045 4.01446 7.74126 4.01219 8.00346C4.00991 8.26566 4.1107 8.51826 4.29286 8.70686L6.29286 10.7069C6.48039 10.8943 6.7347 10.9996 6.99986 10.9996C7.26502 10.9996 7.51933 10.8943 7.70686 10.7069L11.7069 6.70686Z"
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
                    <p class="text-sm font-medium">Kenyan Unincorprated Organisation</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Association</p>
                    <p class="text-sm font-medium">Proprietor</p>
                  </div>
                </div>
                <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                  <a
                    href=""
                    class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                  >
                    View
                  </a>
                </div>
              </div>
            </div>
            <div x-data="{openCard: false}" class="block sm:hidden mx-auto w-full bg-white p-3">
              <button
                id="headlessui-disclosure-button-118"
                type="button"
                aria-expanded="true"
                class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                aria-controls="headlessui-disclosure-panel-119"
              >
                <div>
                  <p class="text-base font-medium text-gray-900">Name</p>
                  <p class="text-sm font-medium text-gray-700">Nikki Creditors Association</p>
                  <div class="flex items-center space-x-2">
                    <p class="text-sm font-medium text-blue-600">
                      C.8/2002
                    </p>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      viewBox="0 0 16 16"
                      fill="none"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M4.26686 1.45486C4.91012 1.4035 5.52077 1.15049 6.01186 0.73186C6.56652 0.259451 7.27129 0 7.99986 0C8.72843 0 9.4332 0.259451 9.98786 0.73186C10.4789 1.15049 11.0896 1.4035 11.7329 1.45486C12.4593 1.51292 13.1413 1.82782 13.6566 2.34313C14.1719 2.85843 14.4868 3.54043 14.5449 4.26686C14.5959 4.90986 14.8489 5.52086 15.2679 6.01186C15.7403 6.56652 15.9997 7.27129 15.9997 7.99986C15.9997 8.72843 15.7403 9.4332 15.2679 9.98786C14.8492 10.4789 14.5962 11.0896 14.5449 11.7329C14.4868 12.4593 14.1719 13.1413 13.6566 13.6566C13.1413 14.1719 12.4593 14.4868 11.7329 14.5449C11.0896 14.5962 10.4789 14.8492 9.98786 15.2679C9.4332 15.7403 8.72843 15.9997 7.99986 15.9997C7.27129 15.9997 6.56652 15.7403 6.01186 15.2679C5.52077 14.8492 4.91012 14.5962 4.26686 14.5449C3.54043 14.4868 2.85843 14.1719 2.34313 13.6566C1.82782 13.1413 1.51292 12.4593 1.45486 11.7329C1.4035 11.0896 1.15049 10.4789 0.73186 9.98786C0.259451 9.4332 0 8.72843 0 7.99986C0 7.27129 0.259451 6.56652 0.73186 6.01186C1.15049 5.52077 1.4035 4.91012 1.45486 4.26686C1.51292 3.54043 1.82782 2.85843 2.34313 2.34313C2.85843 1.82782 3.54043 1.51292 4.26686 1.45486ZM11.7069 6.70686C11.889 6.51826 11.9898 6.26566 11.9875 6.00346C11.9853 5.74126 11.8801 5.49045 11.6947 5.30504C11.5093 5.11963 11.2585 5.01446 10.9963 5.01219C10.7341 5.00991 10.4815 5.1107 10.2929 5.29286L6.99986 8.58586L5.70686 7.29286C5.51826 7.1107 5.26565 7.00991 5.00346 7.01219C4.74126 7.01446 4.49045 7.11963 4.30504 7.30504C4.11963 7.49045 4.01446 7.74126 4.01219 8.00346C4.00991 8.26566 4.1107 8.51826 4.29286 8.70686L6.29286 10.7069C6.48039 10.8943 6.7347 10.9996 6.99986 10.9996C7.26502 10.9996 7.51933 10.8943 7.70686 10.7069L11.7069 6.70686Z"
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
                <div class="border-t mt-4 pt-4 grid grid-cols-2 gap-4">
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Name</p>
                    <p class="text-sm font-medium">Nikki Creditors Association</p>
                    <div class="flex items-center space-x-2">
                      <p class="text-sm font-medium text-blue-600">
                        C.8/2002
                      </p>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        viewBox="0 0 16 16"
                        fill="none"
                      >
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M4.26686 1.45486C4.91012 1.4035 5.52077 1.15049 6.01186 0.73186C6.56652 0.259451 7.27129 0 7.99986 0C8.72843 0 9.4332 0.259451 9.98786 0.73186C10.4789 1.15049 11.0896 1.4035 11.7329 1.45486C12.4593 1.51292 13.1413 1.82782 13.6566 2.34313C14.1719 2.85843 14.4868 3.54043 14.5449 4.26686C14.5959 4.90986 14.8489 5.52086 15.2679 6.01186C15.7403 6.56652 15.9997 7.27129 15.9997 7.99986C15.9997 8.72843 15.7403 9.4332 15.2679 9.98786C14.8492 10.4789 14.5962 11.0896 14.5449 11.7329C14.4868 12.4593 14.1719 13.1413 13.6566 13.6566C13.1413 14.1719 12.4593 14.4868 11.7329 14.5449C11.0896 14.5962 10.4789 14.8492 9.98786 15.2679C9.4332 15.7403 8.72843 15.9997 7.99986 15.9997C7.27129 15.9997 6.56652 15.7403 6.01186 15.2679C5.52077 14.8492 4.91012 14.5962 4.26686 14.5449C3.54043 14.4868 2.85843 14.1719 2.34313 13.6566C1.82782 13.1413 1.51292 12.4593 1.45486 11.7329C1.4035 11.0896 1.15049 10.4789 0.73186 9.98786C0.259451 9.4332 0 8.72843 0 7.99986C0 7.27129 0.259451 6.56652 0.73186 6.01186C1.15049 5.52077 1.4035 4.91012 1.45486 4.26686C1.51292 3.54043 1.82782 2.85843 2.34313 2.34313C2.85843 1.82782 3.54043 1.51292 4.26686 1.45486ZM11.7069 6.70686C11.889 6.51826 11.9898 6.26566 11.9875 6.00346C11.9853 5.74126 11.8801 5.49045 11.6947 5.30504C11.5093 5.11963 11.2585 5.01446 10.9963 5.01219C10.7341 5.00991 10.4815 5.1107 10.2929 5.29286L6.99986 8.58586L5.70686 7.29286C5.51826 7.1107 5.26565 7.00991 5.00346 7.01219C4.74126 7.01446 4.49045 7.11963 4.30504 7.30504C4.11963 7.49045 4.01446 7.74126 4.01219 8.00346C4.00991 8.26566 4.1107 8.51826 4.29286 8.70686L6.29286 10.7069C6.48039 10.8943 6.7347 10.9996 6.99986 10.9996C7.26502 10.9996 7.51933 10.8943 7.70686 10.7069L11.7069 6.70686Z"
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
                    <p class="text-sm font-medium">Kenyan Unincorprated Organisation</p>
                  </div>
                  <div class="col-span-1">
                    <p class="text-xs text-gray-600">Association</p>
                    <p class="text-sm font-medium">Proprietor</p>
                  </div>
                </div>
                <div class="mt-3 flex justify-end sm:mt-0 sm:ml-4 border-t pt-4 space-x-3">
                  <a
                    href=""
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
    """
  end
end
