defmodule BrsWeb.CompanyLive.Tabs.DocumentsComponent do
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
        <div class="bg-white rounded-lg shadow-sm h-min">
          <div class="divide-y divide-gray-200">
            <div class="items-center justify-between px-4 py-4 space-y-3 lg:space-x-2 lg:space-y-0 lg:flex">
              <div class="items-center">
                <p class="m-0 text-sm font-medium text-primary-600">
                  Name Reservation Certificate
                </p>
                <p class="m-0 text-sm font-normal text-gray-500">
                  Fri 10 May 2022, 12:25:31 PM
                </p>
              </div>
              <div class="flex items-center space-x-3 lg:justify-center">
                <button
                  type="button"
                  class="inline-flex items-center px-3 py-2 space-x-2 text-sm font-medium leading-4 text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2"
                >
                  <span>Download</span>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="18"
                    viewBox="0 0 20 18"
                    fill="none"
                  >
                    <path
                      d="M6.66699 13.1667L10.0003 16.5M10.0003 16.5L13.3337 13.1667M10.0003 16.5V9M16.667 12.9524C17.6849 12.1117 18.3337 10.8399 18.3337 9.41667C18.3337 6.88536 16.2816 4.83333 13.7503 4.83333C13.5682 4.83333 13.3979 4.73833 13.3054 4.58145C12.2187 2.73736 10.2124 1.5 7.91699 1.5C4.46521 1.5 1.66699 4.29822 1.66699 7.75C1.66699 9.47175 2.3632 11.0309 3.48945 12.1613"
                      stroke="#344054"
                      stroke-width="1.66667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                    </path>
                  </svg>
                </button>
              </div>
            </div>
            <div class="items-center justify-between px-4 py-4 space-y-3 lg:space-x-2 lg:space-y-0 lg:flex">
              <div class="items-center">
                <p class="m-0 text-sm font-medium text-primary-600">
                  Receipt
                </p>
                <p class="m-0 text-sm font-normal text-gray-500">
                  Fri 10 May 2022, 12:25:31 PM
                </p>
              </div>
              <div class="flex items-center space-x-3 lg:justify-center">
                <button
                  type="button"
                  class="inline-flex items-center px-3 py-2 space-x-2 text-sm font-medium leading-4 text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2"
                >
                  <span>Download</span>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="18"
                    viewBox="0 0 20 18"
                    fill="none"
                  >
                    <path
                      d="M6.66699 13.1667L10.0003 16.5M10.0003 16.5L13.3337 13.1667M10.0003 16.5V9M16.667 12.9524C17.6849 12.1117 18.3337 10.8399 18.3337 9.41667C18.3337 6.88536 16.2816 4.83333 13.7503 4.83333C13.5682 4.83333 13.3979 4.73833 13.3054 4.58145C12.2187 2.73736 10.2124 1.5 7.91699 1.5C4.46521 1.5 1.66699 4.29822 1.66699 7.75C1.66699 9.47175 2.3632 11.0309 3.48945 12.1613"
                      stroke="#344054"
                      stroke-width="1.66667"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                    </path>
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
