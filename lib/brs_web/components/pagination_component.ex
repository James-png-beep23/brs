defmodule BrsWeb.PaginationComponent do
  use BrsWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <nav
      class="flex items-center bg-white justify-between px-3  pr-4 sm:pr-6 border-t border-gray-300 py-3"
      aria-label="Pagination"
    >
      <div class="block">
        <p class="text-sm text-gray-700">
          Showing <span class="font-medium"><%= (assigns.page - 1) * assigns.page_size + 1 %></span>
          to
          <span class="font-medium">
            <%= min(assigns.page * assigns.page_size, assigns.total_entries) %>
          </span>
          of <span class="font-medium"><%= @total_entries %></span>
          results
        </p>
      </div>
      <div class="flex justify-between sm:justify-end">
        <!-- Active:  class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"  -->
        <!-- Previous Button -->
        <a
          href="#"
          phx-click="change_page"
          phx-value-page={@page - 1}
          phx-target={@myself}
          class={"px-4 py-2 text-sm font-medium #{if @page == 1, do: "text-gray-400 cursor-not-allowed", else: "text-gray-700"} bg-white border border-gray-300 rounded-md hover:bg-gray-50"}
        >
          Previous
        </a>
        <!-- Next Button -->
        <a
          href="#"
          phx-click="change_page"
          phx-value-page={@page + 1}
          phx-target={@myself}
          class={"px-4 py-2 ml-3 text-sm font-medium #{if @page == @total_pages, do: "text-gray-400 cursor-not-allowed", else: "text-gray-700"} bg-white border border-gray-300 rounded-md hover:bg-gray-50"}
        >
          Next
        </a>
      </div>
    </nav>
    """
  end

  @impl true
  def handle_event("change_page", %{"page" => page_str}, socket) do
    page = String.to_integer(page_str)

    if page >= 1 and page <= socket.assigns.total_pages do
      socket.assigns.on_change_page.(%{page: page})
      {:noreply, assign(socket, :page, page)}
    else
      {:noreply, socket}
    end
  end
end
