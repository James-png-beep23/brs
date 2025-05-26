defmodule BrsWeb.BusinessRegisterLive.Components.DashboardNavComponent do
  use BrsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{switch_tab: index}, socket) do
    {:ok, socket |> assign(active_tab: index)}
  end

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="px-0 mt-6 sm:z-20 sm:top-5">
      <!-- Desktop Tabs -->
      <div class="hidden lg:block relative bg-white border-b-4 border-[#0A2543] after:content-[''] after:absolute after:right-0 after:bottom-0 after:h-1 after:bg-[#ED2926] after:sm:w-64 after:w-24 after:-mb-1">
        <div class="px-4 py-3 bg-white border-b border-primary-910">
          <div class="flex">
            <div>
              <p class="text-base font-semibold text-primary-500">
                <%= BrsWeb.ViewHelpers.full_name(@current_user) %>
              </p>
              <p class="text-xs font-medium text-black">CITIZEN</p>
            </div>
            <div class="ml-auto">
              <button
                phx-click={
                  JS.toggle_class("hidden", to: "#user-details")
                  |> JS.toggle_class("rotate-180", to: "#user-details-icon")
                }
                class="p-1 text-[#C9CED5] rounded border border-[#C9CED5] h-5 w-5 focus:border-transparent focus:outline-none focus-within:text-primary-500 focus:ring-1 focus:ring-primary-500"
              >
                <svg
                  id="user-details-icon"
                  class="h-1.5 w-2.5 transition-transform ease-linear duration-300 rotate-0"
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
              </button>
            </div>
          </div>
        </div>
        <div
          id="user-details"
          class="px-4 py-4 transition-transform duration-300 ease-linear border-b bg-backdrop border-primary-910 hidden"
        >
          <dl class="grid gap-6 grid-col-1 sm:grid-cols-3 xl:grid-cols-5">
            <div class="col-span-1">
              <dt class="text-sm text-gray-500">ID Number.</dt>
              <dd class="text-base font-medium text-primary-500"><%= @current_user.id_number %></dd>
            </div>
            <div class="col-span-1">
              <dt class="text-sm text-gray-500">Phone Number</dt>
              <dd class="text-base font-medium text-primary-500">
                <%= @current_user.phone_number %>
              </dd>
            </div>
            <div class="col-span-1">
              <dt class="text-sm text-gray-500">Email Address</dt>
              <dd class="text-base font-medium lowercase text-primary-500">
                <%= @current_user.email %>
              </dd>
            </div>
          </dl>
        </div>
        <nav aria-label="Tabs" class="relative z-0 flex justify-start p-3 space-x-4">
          <.live_component
            module={BrsWeb.BusinessRegisterLive.Components.TabsComponent}
            tabs={@tabs}
            active_tab={@active_tab}
            id="nav-tabs"
            cb={fn tab -> send_update(@myself, switch_tab: tab) end}
          />
        </nav>
        <!-- border -->
        <div class="absolute inset-x-0 top-0 bottom-0 border border-b-0 border-gray-300 rounded-tl-lg rounded-tr-lg pointer-events-none">
        </div>
      </div>
      <div class="mt-8 px-0 sm:px-0 ">
        <%= for tab <- @tabs do %>
          <section :if={@active_tab == tab.id}>
            <.live_component
              module={tab.mod}
              id={"dashboard-tab-#{tab.id}" }
              current_registry={@current_registry}
              current_account={@current_account}
            />
          </section>
        <% end %>
      </div>
    </div>
    """
  end
end
