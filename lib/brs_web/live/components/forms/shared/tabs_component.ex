defmodule BrsWeb.Forms.Shared.TabsComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <!-- mobile Tabs -->
      <div class="mb-6 lg:hidden">
        <form phx-change="switch_tab" phx-target={@myself}>
          <label for="tabs" class="sr-only">Select a tab</label>
          <!-- Use an "onChange" listener to redirect the user to the selected tab URL. -->
          <select
            id="tabs"
            name="index"
            class="block w-full py-2 pl-3 pr-10 text-base border-gray-300 rounded-md focus:border-primary-500 focus:outline-none focus:ring-primary-500 sm:text-sm"
          >
            <%= for tab <- @tabs do %>
              <option value={tab.id} selected={tab.id == @active_tab}>
                <%= tab.title %>
              </option>
            <% end %>
          </select>
        </form>
      </div>
      <!-- desktop Tabs -->
      <div class="hidden lg:block">
        <div class="mb-5 border-b border-gray-300">
          <nav>
            <div class="flex flex-wrap space-x-3" aria-label="Tabs">
              <%= for tab <- @tabs do %>
                <a
                  href="#"
                  phx-click="switch_tab"
                  phx-value-index={tab.id}
                  phx-target={@myself}
                  class={"whitespace-nowrap pb-3 px-1 border-b-2 font-medium text-sm inline-block mr-3 lg:mr-3 xl:mr-5 #{if @active_tab == tab.id, do: ~s'border-blue-500 text-blue-500', else: ~s'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"}
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

  def handle_event("switch_tab", %{"index" => index}, socket) do
    send(self(), {:switch_tab, index})
    {:noreply, assign(socket, :active_tab, index) |> assign(:active_tab, index)}
  end
end
