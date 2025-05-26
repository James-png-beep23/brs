defmodule BrsWeb.AdminApplicationLive.TabsComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <!-- mobile Tabs -->
      <div class="lg:hidden mb-6">
        <form phx-change="switch_tab" phx-target={@myself}>
          <label for="tabs" class="sr-only">Select a tab</label>
          <!-- Use an "onChange" listener to redirect the user to the selected tab URL. -->
          <select
            id="tabs"
            name="index"
            class="block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-primary-500 focus:outline-none focus:ring-primary-500 sm:text-sm"
          >
            <%= for tab <- @tabs do %>
              <option value={tab.id} selected={tab.id == @mobile_active_tab}>
                <%= tab.title %>
              </option>
            <% end %>
          </select>
        </form>
      </div>
      <!-- desktop Tabs -->
      <div class="hidden lg:block">
        <div class="border-b border-gray-300 mb-5">
          <nav>
            <div class="flex justify-start items-center space-x-1" aria-label="Tabs">
              <%= for tab <- @tabs do %>
                <a
                  href="#"
                  phx-click="switch_tab"
                  phx-value-index={tab.id}
                  phx-target={@myself}
                  class={"whitespace-nowrap pb-3 px-4 border-b-2 font-medium text-base truncate inline-block mt-4 #{if @active_tab == tab.id, do: 'border-blue-500 text-primary-500', else: 'border-transparent text-gray-900 hover:text-gray-800 hover:border-gray-300'}"}
                  aria-current={if @active_tab == tab.id, do: "page", else: "false"}
                >
                  <%= tab.title %>
                </a>
              <% end %>
            </div>
          </nav>
        </div>
      </div>
    </div>
    """
  end

  # Handle events for changing tabs
  def handle_event("switch_tab", %{"index" => index}, socket) do
    send(self(), {:switch_tab, index})
    {:noreply, assign(socket, :active_tab, index) |> assign(:mobile_active_tab, index)}
  end
end
