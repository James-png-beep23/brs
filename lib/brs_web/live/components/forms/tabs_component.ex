defmodule BrsWeb.Forms.TabsComponent do
  use BrsWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- mobile Tabs -->
      <div class="mb-4 mt-4 px-4 lg:hidden">
        <form phx-change="switch_tab" phx-target={@myself}>
          <label for="tabs" class="sr-only">Select a tab</label>
          <!-- Use an "onChange" listener to redirect the user to the selected tab URL. -->
          <select
            id="tabs"
            name="index"
            class="block w-full py-2 pl-3 pr-10 text-base text-gray-800 border-gray-300 rounded-md focus:border-primary-500 focus:outline-none focus:ring-primary-500 sm:text-sm"
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
        <div class="mb-5 md:mb-6 border-b border-gray-300">
          <nav>
            <div class="flex flex-wrap items-center px-4 pb-3 space-x-4 border-b border-gray-200">
              <%= for tab <- @tabs do %>
                <a
                  href="#"
                  phx-click="switch_tab"
                  phx-value-index={tab.id}
                  phx-target={@myself}
                  class={"first:ml-4 whitespace-nowrap px-4 py-2 border-b-2 font-medium text-base inline-block #{if @active_tab == tab.id, do: "border-red-500 text-primary-500", else: "border-transparent text-gray-900 hover:text-gray-800 hover:border-gray-300"}"}
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

  @impl true
  def handle_event("switch_tab", %{"index" => index}, socket) do
    # send(self(), {:switch_tab, index})
    {:noreply, assign(socket, :active_tab, index) |> assign(:active_tab, index)}
  end
end
