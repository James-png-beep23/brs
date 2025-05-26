defmodule BrsWeb.BusinessRegisterLive.Components.TabsComponent do
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <nav class="relative z-0 flex justify-start p-3 space-x-4">
      <%= for tab <- @tabs do %>
        <a
          href="#"
          phx-click="switch_tab"
          phx-value-index={tab.id}
          phx-target={@myself}
          class={"#{if @active_tab == tab.id, do: "bg-[#EAECF5] font-bold"} text-primary-500 flex items-center text-primary-500 hover:text-gray-700 rounded-md group relative min-w-0 overflow-hidden py-2 px-4 text-sm font-medium text-center hover:bg-gray-50 focus:z-10 transition-colors ease-in-out duration-300"}
          aria-current={if @active_tab == tab.id, do: "page", else: "false"}
        >
          <span><%= tab.title %></span>
          <span
            aria-hidden="true"
            class="hidden absolute top-0 right-0 mr-3 w-4 h-4 items-center justify-center bg-alert-600 rounded-full py-0.5 px-1.5 text-white text-xs font-bold"
          >
          </span>
        </a>
      <% end %>
    </nav>
    """
  end

  # Handle events for changing tabs
  @impl true
  def handle_event("switch_tab", %{"index" => index}, socket) do
    index = String.to_integer(index)
    socket.assigns.cb.(index)

    {:noreply, assign(socket, :active_tab, index)}
  end
end
