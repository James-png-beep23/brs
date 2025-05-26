defmodule BrsWeb.Components.ClientProfileComponent do
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
                <.avatar size="sm" name={@user.first_name <> " " <> @user.last_name} />
              </div>
              <div>
                <p class="text-base text-primary-500 font-semibold "><%= full_name(@user) %></p>
                <p class="text-xs text-black font-medium ">CITIZEN</p>
              </div>
            </div>
            <div class="ml-auto ">
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#client-details")
                  |> JS.toggle_class("rotate-180", to: "#client-details-icon")
                }
                class="p-1 text-[#C9CED5] rounded border border-[#C9CED5] h-5 w-5 focus:border-transparent focus:outline-none focus-within:text-primary-500
                                            focus:ring-1 focus:ring-primary-500 "
              >
                <svg
                  id="client-details-icon"
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
          id="client-details"
          class="px-4 py-4 bg-backdrop transition-transform ease-linear duration-300 border-b border-primary-910 hidden "
        >
          <dl class="grid grid-col-1 gap-6 sm:grid-cols-3 xl:grid-cols-5 ">
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">ID Number.</dt>
              <dd class="text-base text-primary-500 font-medium "><%= @user.id_number %></dd>
            </div>
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">Phone Number</dt>
              <dd class="text-base text-primary-500 font-medium "><%= @user.phone_number %></dd>
            </div>
            <div class="col-span-1 ">
              <dt class="text-sm text-gray-500 ">Email Address</dt>
              <dd class="text-base text-primary-500 font-medium lowercase "><%= @user.email %></dd>
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
