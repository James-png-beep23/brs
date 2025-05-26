defmodule BrsWeb.BusinessRegisterLive.Components.Services do
  alias Brs.Registries.Registry

  alias Brs.Services
  use BrsWeb, :live_component
  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{current_registry: current_registry} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:services, list_services(current_registry))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="px-0 mt-8 sm:px-0 ">
      <div class="px-0 mt-4 sm:px-0 ">
        <p class="mb-1 text-lg font-medium leading-none sm:text-2xl text-primary-500">Services</p>

        <p class="mt-0 text-sm text-gray-500">
          Register different types of entities and get access to copies of records for companies and businesses as an individual.
        </p>

        <hr class="text-primary-910 mt-[10px] mb-4" />
      </div>
      <!-- Search  -->
      <div class="px-0 mt-4 mb-4 sm:px-0 sm:mb-5">
        <form class="flex w-full md:ml-0" action="#" method="GET">
          <label for="search-field" class="sr-only">Search</label>
          <div class="relative w-full text-gray-400 bg-white rounded-lg focus-within:text-gray-600">
            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
              <svg
                width="20"
                height="20"
                viewBox="0 0 20 20"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M17.5 17.5L14.5834 14.5833M16.6667 9.58333C16.6667 13.4954 13.4954 16.6667 9.58333 16.6667C5.67132 16.6667 2.5 13.4954 2.5 9.58333C2.5 5.67132 5.67132 2.5 9.58333 2.5C13.4954 2.5 16.6667 5.67132 16.6667 9.58333Z"
                  stroke="#667085"
                  stroke-width="1.66667"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                </path>
              </svg>
            </div>
            <input
              id="search-field"
              value=""
              class="block w-full py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-500 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 focus:border-white focus:outline-none focus:ring-1 focus:ring-offset-1 focus:ring-primary-500 sm:text-sm"
              placeholder="Search"
              type="search"
              name="search"
            />
          </div>
        </form>
      </div>
      <!-- section body -->
      <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
        <%= for service <- @services do %>
          <div class="px-3 py-4 sm:pl-6 sm:pr-4 sm:py-4 lg:min-h-[74px] bg-white border rounded-lg border-primary-910 flex flex-row justify-between items-center">
            <p class="text-base font-medium capitalize text-primary-500">
              <%= service.name %>
            </p>
            <div class="flex flex-col justify-center sm:mt-0 sm:ml-4">
              <a
                class="ml-3 items-center min-w-[70px] text-center px-3.5 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-500 hover:bg-primary-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-100"
                href={~p"/services/#{service.id}/apply"}
                type="button"
              >
                Apply
              </a>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp list_services(%Registry{} = registry) do
    Services.services_registry_query(registry.id)
    |> Services.preload_query(:registry)
    |> Services.get_services()
  end

  defp list_services(_), do: []
end
