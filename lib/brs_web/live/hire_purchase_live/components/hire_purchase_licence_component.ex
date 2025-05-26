defmodule BrsWeb.HirePurchaseLive.HirePurchaseLicenceComponent do
  use BrsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div class="max-w-3xl">
        <div class="mb-4 px-0 sm:px-0">
          <div class="flex flex-col sm:flex-row sm:items-center justify-between space-y-2 sm:space-y-0">
            <div class="inline-flex justify-start items-center space-x-3">
              <p class="text-lg sm:text-2xl font-semibold leading-none text-primary-500 mb-1 sm:mb-0">
                HP-43456
              </p>
              <span class="inline-flex items-center gap-x-1.5 rounded-full bg-green-100 px-2 py-1 text-xs font-medium text-green-700">
                <svg class="h-1.5 w-1.5 fill-green-500" viewBox="0 0 6 6" aria-hidden="true">
                  <circle cx="3" cy="3" r="3" />
                </svg>
                Active
              </span>
            </div>

            <div class="flex items-center justify-between space-x-3">
              <button
                type="button"
                class="inline-flex items-center rounded-md border border-gray-300 bg-white px-3 py-2 text-sm font-medium leading-4 text-primary-500 shadow-sm hover:bg-primary-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-primary-600 focus:ring-offset-2"
              >
                Download License
              </button>
            </div>
          </div>
        </div>
        <!-- services section -->
        <div class="col-span-12 py-0">
          <img src="../assets/output.jpg" class="w-full" alt="" />
        </div>
        <!-- services section -->
      </div>
    </div>
    """
  end
end
