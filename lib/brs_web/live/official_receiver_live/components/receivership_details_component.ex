defmodule BrsWeb.OfficialReceiverLive.ReceivershipDetailsComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4 max-w-5xl">
      <!-- Insolvency Practitioner -->
      <div class="bg-white overflow-hidden shadow rounded-lg">
        <div class="border-b border-gray-200 px-3 sm:px-4 py-3 sm:py-3">
          <p class="text-base font-semibold text-primary-500">Insolvency Practitioner</p>
        </div>
        <div class="space-y-4 py-4 px-4 sm:px-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-x-4 gap-y-2 sm:gap-y-3 items-center">
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Appointment date</p>
            <p class="text-base font-medium text-gray-800 ">14 June 2024</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Name</p>
            <p class="text-base font-medium text-gray-800 ">John Doe Kamau</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">ID Number</p>
            <p class="text-base font-medium text-gray-800 ">12435617</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Mobile No.</p>
            <p class="text-base font-medium text-gray-800 ">+254720984502</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Email Address</p>
            <p class="text-base font-medium text-gray-800 ">info@bizimungu.com</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Address</p>
            <p class="text-base font-medium text-gray-800 ">2333, Nairobi, Gitanga Road</p>
          </div>
        </div>
      </div>
      <!--  -->
      <div class="bg-white overflow-hidden shadow rounded-lg">
        <div class="border-b border-gray-200 px-3 sm:px-4 py-3 sm:py-3">
          <p class="text-base font-semibold text-primary-500">Liquidator</p>
        </div>
        <div class="space-y-4 py-4 px-4 sm:px-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-x-4 gap-y-2 sm:gap-y-3 items-center">
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Appointment date</p>
            <p class="text-base font-medium text-gray-800 ">14 June 2024</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Name</p>
            <p class="text-base font-medium text-gray-800 ">John Doe Kamau</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">ID Number</p>
            <p class="text-base font-medium text-gray-800 ">12435617</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Mobile No.</p>
            <p class="text-base font-medium text-gray-800 ">+254720984502</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Email Address</p>
            <p class="text-base font-medium text-gray-800 ">info@bizimungu.com</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Address</p>
            <p class="text-base font-medium text-gray-800 ">2333, Nairobi, Gitanga Road</p>
          </div>
        </div>
      </div>
      <!-- Administrator -->
      <div class="bg-white overflow-hidden shadow rounded-lg">
        <div class="border-b border-gray-200 px-3 sm:px-4 py-3 sm:py-3">
          <p class="text-base font-semibold text-primary-500">Administrator</p>
        </div>
        <div class="space-y-4 py-4 px-4 sm:px-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-x-4 gap-y-2 sm:gap-y-3 items-center">
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Appointment date</p>
            <p class="text-base font-medium text-gray-800 ">14 June 2024</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Name</p>
            <p class="text-base font-medium text-gray-800 ">John Doe Kamau</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">ID Number</p>
            <p class="text-base font-medium text-gray-800 ">12435617</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Mobile No.</p>
            <p class="text-base font-medium text-gray-800 ">+254720984502</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Email Address</p>
            <p class="text-base font-medium text-gray-800 ">info@bizimungu.com</p>
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium mb-0.5">Address</p>
            <p class="text-base font-medium text-gray-800 ">2333, Nairobi, Gitanga Road</p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
