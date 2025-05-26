defmodule BrsWeb.NoticesLive.ShowComponent do
  use BrsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-6xl">
      <div class="mb-4 px-0 sm:px-0">
        <div class="flex flex-col sm:flex-row sm:items-center justify-between space-y-2 sm:space-y-0">
          <p class="text-lg sm:text-2xl font-semibold leading-none text-primary-500 mb-1 sm:mb-0">
            Notice IN-43456
          </p>
          <div class="flex items-center justify-between space-x-3">
            <button
              type="button"
              class="inline-flex items-center rounded-md border border-gray-300 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
            >
              Download Notice
            </button>
          </div>
        </div>
      </div>
      <!-- services section -->
      <div class="grid grid-cols-12 gap-6 col-span-12 py-0">
        <div class="bg-white border border-gray-300 rounded-lg col-span-12 md:col-span-7 xl:col-span-8 h-min">
          <div class="items-center px-4 py-3 border-b border-gray-300">
            <p class="text-lg font-semibold text-primary-500 m-0">
              Notice Details
            </p>
          </div>
          <div class="divide-y divide-gray-300 px-4">
            <div class="flex items-center  py-4">
              <p class="text-sm font-medium text-gray-900 m-0">
                Part A - Particulars of Guarantors
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Name:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                Mwiti Ian Andrew
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Type:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                Kenyan Citizen
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Identifier:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">23142536</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">KRA PIN:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">A654567890R</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Postal Address:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">-</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Postal Code</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">00100</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Email Address</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                drew@gmail.com
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Telephone Number:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">0745345678</p>
            </div>
            <div class="flex items-center  py-4">
              <p class="text-sm font-medium text-gray-900 m-0">
                Part B - Particulars of Creditors
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Name:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                Mwiti Ian Andrew
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Type:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                Kenyan Citizen
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Identifier:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">23142536</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">KRA PIN:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">A654567890R</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Postal Address:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">-</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Postal Code</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">00100</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Email Address</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                drew@gmail.com
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Telephone Number:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">0745345678</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">
                Category of Secured Credentials
              </p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">Consensual</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">
                Type of Non Secured Creditor:
              </p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">N/A</p>
            </div>
            <div class="flex items-center  py-4">
              <p class="text-sm font-medium text-gray-900 m-0">
                Part C- Details of Collateral
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Collateral Type:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                motot_vehicle
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Description:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">Toyota</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Chassis Number:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">
                987654356789
              </p>
            </div>
            <div class="flex items-center  py-4">
              <p class="text-sm font-medium text-gray-900 m-0">
                Part D - Particulars of Secured Loan
              </p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">Currency Secured:</p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">KES</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">
                Maximum Amount Secured:
              </p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">1000000</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">
                Period of Effectiveness in Months
              </p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">120</p>
            </div>
            <div class="flex items-center justify-between space-x-3 py-4">
              <p class="font-medium text-sm text-gray-500 leading-5 flex-1">
                Guarantor Authorization Obtained:
              </p>
              <p class="font-medium text-sm text-gray-900 leading-5 flex-1 text-right">Yes</p>
            </div>
          </div>
        </div>

        <div class="bg-white border border-gray-300 rounded-lg col-span-12 md:col-span-5 xl:col-span-4 h-min">
          <div class="items-center px-4 py-3 border-b border-gray-200">
            <p class="text-base font-semibold text-gray-700 uppercase m-0">
              history of Amendments
            </p>
          </div>
          <div class="py-4 pl-2 pr-4">
            <nav aria-label="Progress">
              <ol role="list" class="overflow-hidden">
                <li class="relative pb-10">
                  <div
                    class="absolute left-4 top-4 -ml-px mt-0.5 h-full w-0.5 bg-gray-300"
                    aria-hidden="true"
                  >
                  </div>
                  <!-- Complete Step -->
                  <a href="#" class="group relative flex items-start">
                    <span class="flex h-9 items-center" aria-hidden="true">
                      <span class="relative z-10 flex h-2.5 w-8 items-center justify-center rounded-full border-2 border-transparent bg-white">
                        <span class="h-2.5 w-2.5 rounded-full bg-gray-800 group-hover:bg-gray-800">
                        </span>
                      </span>
                    </span>
                    <span class="ml-4 flex min-w-0 flex-col">
                      <span class="text-sm font-semibold">Amendment 4</span>
                      <span class="text-sm text-gray-400">FRI May 20,2022 | 12:25:31</span>
                    </span>
                  </a>
                </li>
                <li class="relative pb-10">
                  <div
                    class="absolute left-4 top-4 -ml-px mt-0.5 h-full w-0.5 bg-gray-300"
                    aria-hidden="true"
                  >
                  </div>
                  <!-- Current Step -->
                  <a href="#" class="group relative flex items-start" aria-current="step">
                    <span class="flex h-9 items-center" aria-hidden="true">
                      <span class="relative z-10 flex h-2.5 w-8 items-center justify-center rounded-full border-2 border-transparent bg-white">
                        <span class="h-2.5 w-2.5 rounded-full bg-gray-300 group-hover:bg-gray-300">
                        </span>
                      </span>
                    </span>
                    <span class="ml-4 flex min-w-0 flex-col">
                      <span class="text-sm font-semibold text-gray-600">Amendment 3</span>
                      <span class="text-sm text-gray-400">FRI May 20,2022 | 12:25:31</span>
                    </span>
                  </a>
                </li>
                <li class="relative pb-10">
                  <div
                    class="absolute left-4 top-4 -ml-px mt-0.5 h-full w-0.5 bg-gray-300"
                    aria-hidden="true"
                  >
                  </div>
                  <!-- Upcoming Step -->
                  <a href="#" class="group relative flex items-start">
                    <span class="flex h-9 items-center" aria-hidden="true">
                      <span class="relative z-10 flex h-2.5 w-8 items-center justify-center rounded-full border-2 border-transparent bg-white">
                        <span class="h-2.5 w-2.5 rounded-full bg-gray-300 group-hover:bg-gray-300">
                        </span>
                      </span>
                    </span>
                    <span class="ml-4 flex min-w-0 flex-col">
                      <span class="text-sm font-semibold text-gray-600">Amendment 2</span>
                      <span class="text-sm text-gray-400">FRI May 20,2022 | 12:25:31</span>
                    </span>
                  </a>
                </li>
                <li class="relative">
                  <!-- Upcoming Step -->
                  <a href="#" class="group relative flex items-start">
                    <span class="flex h-9 items-center" aria-hidden="true">
                      <span class="relative z-10 flex h-2.5 w-8 items-center justify-center rounded-full border-2 border-transparent bg-white">
                        <span class="h-2.5 w-2.5 rounded-full bg-gray-300 group-hover:bg-gray-300">
                        </span>
                      </span>
                    </span>
                    <span class="ml-4 flex min-w-0 flex-col">
                      <span class="text-sm font-semibold text-gray-600">Amendment 2</span>
                      <span class="text-sm text-gray-400">FRI May 20,2022 | 12:25:31</span>
                    </span>
                  </a>
                </li>
              </ol>
            </nav>
          </div>
        </div>
      </div>
      <!-- services section -->
    </div>
    """
  end
end
