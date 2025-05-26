defmodule BrsWeb.BusinessRegisterLive.Components.Business do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col mb-4">
      <div class="bg-white  border border-primary-910 rounded-lg">
        <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center space-y-3 sm:space-y-0 px-4 py-3 border-b border-primary-910">
          <form
            action=""
            class="flex-1 flex flex-col sm:flex-row justify-between sm:items-center sm:space-x-3 space-y-3 sm:space-y-0"
            method="get"
          >
            <div class="rounded-lg w-full">
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
                  class="block w-full rounded-lg border border-gray-300 bg-white py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-500 focus:border-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-primary-500 sm:text-sm"
                  id="q"
                  name="q"
                  placeholder="Enter Registration Number to Search..."
                  type="search"
                />
              </div>
            </div>
            <button
              class="inline-flex items-center justify-center sm:w-32 rounded-md border border-gray-300 bg-white px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
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

        <div class="px-0 sm:px-0 ml-4">
          <h3 class="text-lg sm:text-2xl font-medium leading-none text-primary-500 mb-1">
            Businesses
          </h3>

          <p class="text-sm mt-0 text-neutral-500">
            These are the businesses that have been registered in your name.
          </p>

          <hr class="text-primary-910 mt-[10px] mb-4" />
        </div>

        <div class="sm:overflow-auto mt-4 lg:overflow-visible">
          <!-- table section -->
          <div class="hidden sm:block">
            <div class="flex flex-col">
              <div class="block">
                <div class="block w-full align-middle overflow-x-auto scrollbar">
                  <div class="md:rounded-b-lg w-full">
                    <table class="divide-y divide-primary-910 w-full">
                      <thead class="bg-gray-50">
                        <tr>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            #
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Business
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Date Registered
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Company Type
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Status
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            B.O Status
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 pr-4 sm:pr-6 text-right text-sm font-medium text-gray-500"
                          >
                            &nbsp;
                          </th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-primary-910 bg-white">
                        <tr>
                          <td class="py-4 pl-4 pr-3 text-sm">
                            <div class="font-normal text-gray-500">#</div>
                          </td>
                          <td class="px-3 py-4 text-sm text-gray-500">
                            <div>
                              <a
                                href="/registries/brs/businesses/1905976/services"
                                class="text-sm text-accent-600 font-medium flex items-center space-x-1"
                              >
                                <span>BN-VDCA33VA</span>
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  class="h-4 w-4"
                                  viewBox="0 0 20 20"
                                  fill="currentColor"
                                >
                                  <path
                                    fill-rule="evenodd"
                                    d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                    clip-rule="evenodd"
                                  >
                                  </path>
                                </svg>
                              </a>
                              <p class="text-sm font-medium text-primary-500 capitalize">
                                Business Test
                              </p>
                            </div>
                          </td>
                          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <div class="font-normal text-gray-500">
                              Nov 11, 2021. 12:00 am
                            </div>
                          </td>
                          <td class="px-3 py-4 text-sm text-gray-500">
                            <div class="font-normal text-gray-500">Business Name</div>
                          </td>
                          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500 capitalize">
                            <div class="font-normal text-gray-500">active</div>
                          </td>
                          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <div class="font-normal text-gray-500">--</div>
                          </td>
                          <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                            <div>
                              <a
                                href="/registries/brs/businesses/1905976/services"
                                class="inline-flex items-center rounded-md border border-border-primary-910 bg-white px-3 py-2 text-sm font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2"
                              >
                                View
                              </a>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>

                    <div class="my-3 ml-3 enable-bootstrap">
                      <div class="btn-group btn-group-lg">
                        <a
                          class="btn btn-outline-info  disabled "
                          href="/registries/brs/businesses?before="
                        >
                          <span class="fa fa-chevron-left"></span>
                        </a>
                        <a
                          class="btn btn btn-outline-info  disabled cursor-not-allowed "
                          href="/registries/brs/businesses?after="
                        >
                          <span class="fa fa-chevron-right"></span>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- table section -->

            <!-- Mobile table -->
          <div class="sm:hidden border-none">
            <div
              x-data="{openCard: false}"
              class="block sm:hidden mx-auto w-full border-b border-gray-910 last:border-none"
            >
              <button
                @click="openCard = !openCard"
                id="headlessui-disclosure-button-118"
                type="button"
                aria-expanded="true"
                class="flex items-center w-full justify-between rounded-lg text-left focus:outline-none focus-visible:ring focus-visible:ring-primary-500 focus-visible:ring-opacity-75 p-3"
                aria-controls="headlessui-disclosure-panel-119"
              >
                <div>
                  <a
                    href="/registries/brs/businesses/1905976/services"
                    class="text-sm text-accent-600 font-medium flex items-center space-x-1"
                  >
                    <span>BN-VDCA33VA</span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-4 w-4"
                      viewBox="0 0 20 20"
                      fill="currentColor"
                    >
                      <path
                        fill-rule="evenodd"
                        d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                        clip-rule="evenodd"
                      >
                      </path>
                    </svg>
                  </a>
                  <p class="text-sm font-medium text-primary-500 capitalize">
                    Business Test
                  </p>
                </div>
                <span class="flex justify-center items-center text-[#C9CED5] rounded border border-[#C9CED5] h-5 w-5 focus:border-transparent focus:outline-none focus-within:text-primary-500 focus:ring-1 focus:ring-primary-500">
                  <svg
                    x-bind:class="openCard ? 'rotate-180 transform' : 'rotate-0 transform'"
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
              <div
                x-show="openCard"
                x-transition:enter="transform transition ease-in-out duration-75"
                x-transition:enter-start=" opacity-0"
                x-transition:enter-end="opacity-100"
                x-transition:leave="transform transition ease-in-out duration-75"
                x-transition:leave-start="opacity-100"
                x-transition:leave-end="opacity-0"
                id="headlessui-disclosure-panel-119"
                style="display: none;"
              >
                <div class="space-y-4 border-t mt-0 pt-4 grid grid-cols-2 bg-backdrop p-3">
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Date Registered</p>
                    <p class="text-sm font-medium text-gray-900">Nov 11, 2021. 12:00 am</p>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Company Type</p>
                    <p class="text-sm font-medium text-gray-900">Business Name</p>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">Business Status</p>
                    <span class="inline-flex items-center gap-x-1.5 rounded-md px-0 py-0 text-xs font-medium text-primary-500 ring-0">
                      <svg class="h-1.5 w-1.5 fill-primary-500" viewBox="0 0 6 6" aria-hidden="true">
                        <circle cx="3" cy="3" r="3"></circle>
                      </svg>
                      active
                    </span>
                  </div>
                  <div class="col-span-2">
                    <p class="text-xs text-gray-500">B.O Status</p>
                    <p class="text-sm font-medium text-gray-900">--</p>
                  </div>
                </div>
                <div class="mt-0 flex justify-end border-t p-3 bg-backdrop">
                  <a
                    href="/registries/brs/businesses/1905976/services"
                    class="items-center min-w-[70px] text-center px-2 py-1 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-100"
                  >
                    View
                  </a>
                </div>
              </div>
            </div>
          </div>
          <!-- Mobile table -->
        </div>
      </div>
    </div>
    """
  end
end
