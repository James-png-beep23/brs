defmodule BrsWeb.Components.BusinessProfileComponent do
  use BrsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mt-6 mb-5 sm:mb-6 px-0 sm:z-20 sm:top-5">
      <!-- Desktop Tabs -->
      <div class="block rounded-t-lg relative bg-white border-b-4 border-[#0A2543] after:content-[ ''] after:absolute after:right-0 after:bottom-0 after:h-1 after:bg-[#ED2926] after:sm:w-64 after:w-24 after:-mb-1 ">
        <div class="px-4 py-3 border-b border-primary-910 bg-white ">
          <div class="flex ">
            <div class="flex justify-start items-center space-x-3">
              <div>
                <svg
                  width="50"
                  height="47"
                  viewBox="0 0 50 47"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    x="0.522222"
                    y="0.522222"
                    width="48.0445"
                    height="45.9556"
                    rx="7.83333"
                    fill="#F9FAFB"
                  />
                  <rect
                    x="0.522222"
                    y="0.522222"
                    width="48.0445"
                    height="45.9556"
                    rx="7.83333"
                    stroke="#B2B9C0"
                    stroke-width="1.04444"
                  />
                  <path
                    d="M35.1192 24.9751C31.8536 26.297 28.2839 27.025 24.5442 27.025C20.8046 27.025 17.2349 26.297 13.9692 24.9751M29.2442 16.45V14.1C29.2442 12.8021 28.1921 11.75 26.8942 11.75H22.1942C20.8964 11.75 19.8442 12.8021 19.8442 14.1V16.45M24.5442 23.5H24.556M16.3192 32.9H32.7692C34.0671 32.9 35.1192 31.8479 35.1192 30.55V18.8C35.1192 17.5021 34.0671 16.45 32.7692 16.45H16.3192C15.0214 16.45 13.9692 17.5021 13.9692 18.8V30.55C13.9692 31.8479 15.0214 32.9 16.3192 32.9Z"
                    stroke="#111827"
                    stroke-width="2.08889"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
              <div>
                <div class="flex items-center space-x-1">
                  <p class="text-base text-primary-500 font-semibold ">Nikki Business Limited</p>
                  <svg
                    width="17"
                    height="16"
                    viewBox="0 0 17 16"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      fill-rule="evenodd"
                      clip-rule="evenodd"
                      d="M4.35597 1.45486C4.99923 1.4035 5.60988 1.15049 6.10097 0.73186C6.65563 0.259451 7.3604 0 8.08897 0C8.81754 0 9.52231 0.259451 10.077 0.73186C10.5681 1.15049 11.1787 1.4035 11.822 1.45486C12.5484 1.51292 13.2304 1.82782 13.7457 2.34313C14.261 2.85843 14.5759 3.54043 14.634 4.26686C14.685 4.90986 14.938 5.52086 15.357 6.01186C15.8294 6.56652 16.0888 7.27129 16.0888 7.99986C16.0888 8.72843 15.8294 9.4332 15.357 9.98786C14.9383 10.4789 14.6853 11.0896 14.634 11.7329C14.5759 12.4593 14.261 13.1413 13.7457 13.6566C13.2304 14.1719 12.5484 14.4868 11.822 14.5449C11.1787 14.5962 10.5681 14.8492 10.077 15.2679C9.52231 15.7403 8.81754 15.9997 8.08897 15.9997C7.3604 15.9997 6.65563 15.7403 6.10097 15.2679C5.60988 14.8492 4.99923 14.5962 4.35597 14.5449C3.62954 14.4868 2.94754 14.1719 2.43224 13.6566C1.91693 13.1413 1.60203 12.4593 1.54397 11.7329C1.49261 11.0896 1.2396 10.4789 0.820971 9.98786C0.348562 9.4332 0.0891113 8.72843 0.0891113 7.99986C0.0891113 7.27129 0.348562 6.56652 0.820971 6.01186C1.2396 5.52077 1.49261 4.91012 1.54397 4.26686C1.60203 3.54043 1.91693 2.85843 2.43224 2.34313C2.94754 1.82782 3.62954 1.51292 4.35597 1.45486ZM11.796 6.70686C11.9781 6.51826 12.0789 6.26566 12.0766 6.00346C12.0744 5.74126 11.9692 5.49045 11.7838 5.30504C11.5984 5.11963 11.3476 5.01446 11.0854 5.01219C10.8232 5.00991 10.5706 5.1107 10.382 5.29286L7.08897 8.58586L5.79597 7.29286C5.60737 7.1107 5.35477 7.00991 5.09257 7.01219C4.83037 7.01446 4.57956 7.11963 4.39415 7.30504C4.20874 7.49045 4.10357 7.74126 4.1013 8.00346C4.09902 8.26566 4.19981 8.51826 4.38197 8.70686L6.38197 10.7069C6.5695 10.8943 6.82381 10.9996 7.08897 10.9996C7.35414 10.9996 7.60844 10.8943 7.79597 10.7069L11.796 6.70686Z"
                      fill="#0066FF"
                    />
                  </svg>
                </div>
                <p class="text-xs text-black font-medium ">PUBLIC LIMITED COMPANY</p>
              </div>
            </div>
            <div class="ml-auto ">
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#owner-details")
                  |> JS.toggle_class("rotate-180", to: "#owner-details-icon")
                }
                class="p-1 text-[#C9CED5] rounded border border-[#C9CED5] h-5 w-5 focus:border-transparent focus:outline-none focus-within:text-primary-500
                                            focus:ring-1 focus:ring-primary-500 "
              >
                <svg
                  id="owner-details-icon"
                  class="h-1.5 w-2.5 transition-transform ease-linear duration-300 rotate-0 transform "
                  xmlns="http://www.w3.org/2000/svg "
                  fill="none "
                  viewBox="0 0 10 6 "
                >
                  <path
                    fill="currentColor "
                    fill-rule="evenodd "
                    d="M.293.293a1 1 0 0 1 1.414 0L5 3.586 8.293.293a1 1 0 0 1 1.414 1.414l-4 4a1 1 0 0 1-1.414 0l-4-4a1 1 0 0 1 0-1.414Z "
                    clip-rule="evenodd "
                  >
                  </path>
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div
          id="owner-details"
          class="px-4 py-4 bg-backdrop transition-transform ease-linear duration-300 border-b border-primary-910 hidden "
        >
          <dl class="grid gap-6 grid-col-1 sm:grid-cols-3 xl:grid-cols-5 ">
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">Registration No.</dt>
              <dd class="text-base font-medium text-primary-500 ">
                <%= @business && @business.registration_number %>
              </dd>
            </div>
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">Registration Date</dt>
              <dd class="text-base font-medium text-primary-500 ">
                <%= @business && @business.registration_date %>
              </dd>
            </div>
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">KRA PIN</dt>
              <dd class="text-base font-medium lowercase text-primary-500 ">-</dd>
            </div>
          </dl>
        </div>
        <%= render_slot(@inner_block) %>

        <div class="absolute inset-x-0 pointer-events-none top-0 bottom-0 border border-gray-300 border-b-0 rounded-tl-lg rounded-tr-lg ">
        </div>
      </div>
    </div>
    """
  end
end
