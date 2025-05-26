defmodule BrsWeb.ClientLive.Components.BlacklistedClientComponent do
  use BrsWeb, :live_component
  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4 md:space-y-4">
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
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        ID/PP NO.
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Blacklisted by
                      </th>
                      <th scope="col" class="px-3 py-2.5 text-left text-sm font-medium text-gray-600">
                        Reason for blacklisting
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
                            Nicole Musundi
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            12314231
                          </p>
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
                      <td class="px-3 py-4 text-sm text-gray-500 max-w-56">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Trenes megaliga. Krol deslog på surat. Lanas tiliga. Proteinskifte vire. Popoledes intrassade, reade.
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                        <div class="inline-flex items-center justify-end space-x-3 text-right">
                          <a
                            href={~p"/admin/registries/brs/clients/2"}
                            class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                          >
                            View client
                          </a>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td class="py-4 pl-4 pr-3 text-sm font-medium text-gray-500 sm:pl-4">
                        <div>
                          <p class="text-sm font-medium text-gray-900">
                            Nicole Musundi
                          </p>
                        </div>
                      </td>
                      <td class="px-3 py-4 text-sm text-gray-500">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            12314231
                          </p>
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
                      <td class="px-3 py-4 text-sm text-gray-500 max-w-56">
                        <div>
                          <p class="text-sm font-normal text-gray-500">
                            Trenes megaliga. Krol deslog på surat. Lanas tiliga. Proteinskifte vire. Popoledes intrassade, reade.
                          </p>
                        </div>
                      </td>
                      <td class="px-4 py-4 text-sm text-right text-gray-500 whitespace-nowrap">
                        <div class="inline-flex items-center justify-end space-x-3 text-right">
                          <a
                            href={~p"/admin/registries/brs/clients/2"}
                            class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 bg-white border rounded-md shadow-sm border-primary-500 text-primary-500 hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
                          >
                            View client
                          </a>
                        </div>
                      </td>
                    </tr>
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
              <div x-data="{openCard: false}" class="w-full p-3 mx-auto">
                <button
                  id="headlessui-disclosure-button-118"
                  type="button"
                  aria-expanded="true"
                  class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                  aria-controls="headlessui-disclosure-panel-119"
                >
                  <div>
                    <p class="mb-2 text-sm font-medium text-gray-900">Client</p>
                    <p class="text-sm font-medium text-gray-700">Nicole Musundi</p>
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
                  <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">ID/PP NO.</p>
                      <p class="text-sm font-normal text-gray-900">12314231</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Blacklisted by</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Nicole Musundi
                        </p>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022. 6:12 am
                        </p>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Reason for blacklisting</p>
                      <p class="text-sm font-normal text-gray-900">
                        Trenes megaliga. Krol deslog på surat. Lanas tiliga. Proteinskifte vire. Popoledes intrassade, reade.
                      </p>
                    </div>
                  </div>
                  <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                    <a
                      href={~p"/admin/registries/brs/clients/1"}
                      class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                    >
                      View client
                    </a>
                  </div>
                </div>
              </div>
              <div x-data="{openCard: false}" class="w-full p-3 mx-auto">
                <button
                  id="headlessui-disclosure-button-118"
                  type="button"
                  aria-expanded="true"
                  class="flex items-center justify-between w-full text-left rounded-lg focus:outline-none focus-visible:ring focus-visible:ring-primary-600 focus-visible:ring-opacity-75"
                  aria-controls="headlessui-disclosure-panel-119"
                >
                  <div>
                    <p class="mb-2 text-sm font-medium text-gray-900">Client</p>
                    <p class="text-sm font-medium text-gray-700">Nicole Musundi</p>
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
                  <div class="grid grid-cols-1 gap-3 pt-4 mt-4 border-t">
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">ID/PP NO.</p>
                      <p class="text-sm font-normal text-gray-900">12314231</p>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Blacklisted by</p>
                      <div>
                        <p class="text-sm font-normal text-gray-900">
                          Nicole Musundi
                        </p>
                        <p class="text-sm font-normal text-gray-900">
                          Dec 09, 2022. 6:12 am
                        </p>
                      </div>
                    </div>
                    <div class="col-span-1">
                      <p class="text-xs text-gray-600">Reason for blacklisting</p>
                      <p class="text-sm font-normal text-gray-900">
                        Trenes megaliga. Krol deslog på surat. Lanas tiliga. Proteinskifte vire. Popoledes intrassade, reade.
                      </p>
                    </div>
                  </div>
                  <div class="flex justify-end pt-4 mt-3 space-x-3 border-t sm:mt-0 sm:ml-4">
                    <a
                      href={~p"/admin/registries/brs/clients/1"}
                      class="items-center min-w-[70px] text-center px-3.5 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-600"
                    >
                      View client
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
