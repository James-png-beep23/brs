defmodule BrsWeb.DashboardLive.TabsComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <nav class="relative z-0 flex justify-start">
        <%= for tab <- @tabs do %>
          <section class="relative" aria-label="Tabs">
            <!-- Current: "border-[#00874B] text-[#00874B]", Default: "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300" -->
            <a
              href="#"
              phx-click="change_tab"
              phx-value-index={tab.id}
              phx-target={@myself}
              class={"text-gray-500 flex items-center rounded-md hover:text-gray-700 'rounded-lg group relative min-w-0 overflow-hidden py-2 px-4 text-sm text-center hover:bg-secondary-50 focus:z-10 mr-2 lg:mr-4
              #{if @active_tab == tab.id, do: "text-primary-500 bg-secondary-50 font-bold", else: "text-gray-500 hover:text-gray-700 font-medium"}"}
              aria-current={if @active_tab == tab.id, do: "page", else: "undefined"}
            >
              <span><%= tab.title %></span>
              <span
                :if={tab.corrections}
                aria-hidden="true"
                class="flex absolute top-0 right-0 mr-3 w-4 h-4 items-center justify-center bg-alert-600 rounded-full py-0.5 px-1.5 text-white text-xs font-bold"
              >
                3
              </span>
            </a>
          </section>
        <% end %>
      </nav>
    </div>
    """
  end

  def handle_event("change_tab", %{"index" => index}, socket) do
    send(self(), {:change_tab, index})

    {:noreply,
     assign(socket, :active_tab, index)
     |> assign(:mobile_active_tab, index)}
  end
end
