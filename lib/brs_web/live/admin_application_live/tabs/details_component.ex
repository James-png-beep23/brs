defmodule BrsWeb.AdminApplicationLive.DetailsComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div class="grid grid-cols-4 bg-white overflow-hidden shadow-sm rounded-lg">
        <div class="col-span-4 border-b border-gray-200 px-4 sm:px-4 py-4 sm:py-4 flex items-center justify-start space-x-4">
          <div>
            <p class="text-base font-semibold text-primary-500">Application Details</p>
          </div>
        </div>
        <div class="col-span-4 py-4 sm:py-4 px-4 sm:px-4">
          <div class="grid grid-cols-4 gap-y-4 gap-x-3 items-center">
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Service</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">Private Limited Company</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Workflow</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">Company Registrations</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Ref No</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">NS-YQHSVA</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Created On</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">16 Mar 2023, 07:18am</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Submitted On</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">16 Mar 2023, 07:18am</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Last Updated On</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">16 Mar 2023, 07:18am</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Stage</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">Review</p>
            </div>
            <div class="col-span-4 sm:col-span-2 xl:col-span-1">
              <p class="text-sm text-gray-500 font-medium mb-1">Created By</p>
              <p class="text-base sm:text-base font-medium text-gray-900 ">Helen Wambui Ngugit</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
