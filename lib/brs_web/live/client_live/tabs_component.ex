defmodule BrsWeb.ClientLive.TabsComponent do
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
          class="block w-full py-2 pl-3 pr-10 text-base border-gray-300 text-gray-800 rounded-md focus:border-primary-500 focus:outline-none focus:ring-prborder-primary-500 sm:text-sm"
        >
          <%= for tab <- @tabs do %>
            <option value={tab.id} selected={tab.id == @active_tab}>
              <%= tab.title %>
            </option>
          <% end %>
        </select>
      </div>
      <!-- desktop Tabs -->
      <div class="hidden lg:block">
        <div class="mb-6">
          <nav>
            <%= for tab <- @tabs do %>
              <a
                href="#"
                class={
                  [
                    if(tab.id == @active_tab,
                      do: "text-primary-500 bg-sky-100",
                      else:
                        "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
                    ),
                    "whitespace-nowrap px-3 py-2 font-medium rounded-lg text-sm inline-block mr-3 lg:mr-3"
                  ]
                  |> Enum.join(" ")
                }
                aria-current={if tab.id == @active_tab, do: "page", else: "undefined"}
                phx-click="switch_tab"
                phx-target={@myself}
                phx-value-index={tab.id}
              >
                <!-- Title of the Tab -->
                <span class="inline-block mr-1"><%= tab.title %></span>
                <!-- Notification Count: Only show if greater than 0 -->
                <%= if tab.total_notifications > 0 do %>
                  <span class={"inline-flex items-center justify-center px-1 py-1 rounded-2xl text-xs h-5 w-5 #{if tab.id == @active_tab, do: "bg-sky-200", else: "bg-slate-200"}"}>
                    <%= tab.total_notifications %>
                  </span>
                <% end %>
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
    {:noreply, assign(socket, :active_tab, index)}
  end
end
