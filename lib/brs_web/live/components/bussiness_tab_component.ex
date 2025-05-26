defmodule BrsWeb.Components.BussinessTabComponent do
  use BrsWeb, :live_component
  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- mobile Tabs -->
      <div class="mb-4 mt-4 px-4 lg:hidden">
        <label for="tabs" class="sr-only">Select a tab</label>
        <!-- Use an "onChange" listener to redirect the user to the selected tab URL. -->
        <select
          id="tabs"
          name="tabs"
          phx-change="switch_tab"
          class="block w-full rounded-md border-gray-400 py-2 pl-3 pr-10 text-base text-gray-800 focus:border-primary-500 focus:outline-none focus:ring-primary-500 sm:text-sm"
        >
          <%= for tab <- @tabs do %>
            <option value={tab.id} selected={tab.id == @mobile_active_tab}>
              <%= tab.title %>
            </option>
          <% end %>
        </select>
      </div>
      <!-- desktop Tabs -->
      <div class="hidden lg:block px-4 py-3">
        <div class="mb-0">
          <nav>
            <%= for tab <- @tabs do %>
              <a
                href="#"
                phx-click="switch_tab"
                phx-value-index={tab.id}
                phx-target={@myself}
                class={"inline-flex items-center rounded-lg group relative min-w-0 overflow-hidden py-2 px-4 text-sm text-center focus:z-10 transition-colors ease-in-out duration-300 whitespace-nowrap mr-3 lg:mr-3 xl:mr-3
                   #{if @active_tab == tab.id, do: "text-primary-500 bg-violet-100 hover:text-primary-500 hover:bg-violet-200 font-bold", else: "text-primary-500 font-medium"}"}
                aria-current={if @active_tab == tab.id, do: "page", else: "undefined"}
              >
                <%= tab.title %>
              </a>
            <% end %>
          </nav>
        </div>
      </div>
    </div>
    """
  end

  # Handle events for changing tabs
  @impl true
  def handle_event("switch_tab", %{"index" => index}, socket) do
    send(self(), {:switch_tab, index})
    {:noreply, assign(socket, :active_tab, index) |> assign(:mobile_active_tab, index)}
  end
end
