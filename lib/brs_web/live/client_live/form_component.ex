defmodule BrsWeb.ClientLive.FormComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  def mount(socket) do
    {:ok,
     socket
     |> assign(:client, nil)
     |> assign_form()}
  end

  def render(assigns) do
    ~H"""
    <div class="relative z-50" aria-labelledby="modal-title" role="dialog" aria-modal="true">
      <div class="fixed inset-0 transition-opacity bg-gray-700 bg-opacity-75 backdrop-filter backdrop-blur-sm">
      </div>
      <div class="fixed inset-0 z-50 overflow-y-auto">
        <div class="flex items-end justify-center min-h-full p-4 text-center sm:items-center sm:p-0">
          <!-- Modal panel, show/hide based on modal state.  -->
          <%= if is_nil(@client) do %>
            <.form
              for={@client_id_search_form}
              phx-target={@myself}
              phx-change="validate_search"
              phx-submit="search_client"
              class="relative w-full overflow-hidden text-left transition-all duration-300 ease-in-out transform bg-white divide-y divide-gray-300 rounded-lg shadow-xl sm:max-w-lg"
            >
              <div class="px-4 py-4 sm:py-4 sm:px-4">
                <h1 class="m-0 mb-0 text-lg font-semibold text-gray-700">Blacklist a Client</h1>
              </div>

              <div class="px-4 py-4 space-y-4 sm:py-4 sm:px-4">
                <div class="flex items-end space-x-2 justify-betwee">
                  <div class="flex-1">
                    <label for="client_id" class="block text-sm font-medium leading-6 text-gray-500">
                      Enter Client ID
                    </label>
                    <div class="mt-1">
                      <input
                        type="text"
                        id="client_id"
                        autocomplete="client_id"
                        placeholder="Search"
                        phx-debounce="blur"
                        name={input_name(@client_id_search_form, :client_id)}
                        value={input_value(@client_id_search_form, :client_id)}
                        class="block w-full text-base rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 bg-white placeholder:text-gray-800 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                      />
                    </div>
                  </div>
                  <button
                    type="submit"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-white border-0 rounded-md shadow-sm h-fit bg-primary-500 hover:text-white hover:bg-primary-600 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Search
                  </button>
                </div>
              </div>

              <div class="flex items-center justify-end px-4 py-4 sm:py-4 sm:px-4">
                <div class="sm:space-x-1">
                  <button
                    phx-click="toggle_blacklist_modal"
                    type="button"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md shadow-sm hover:text-gray-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Cancel
                  </button>
                  <button
                    type="button"
                    disabled
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-white bg-gray-400 border border-gray-400 rounded-md shadow-sm hover:text-white hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Blacklist Client
                  </button>
                </div>
              </div>
            </.form>
          <% else %>
            <!-- after search.  -->
            <form
              phx-submit="save"
              phx-target={@myself}
              class="relative w-full overflow-hidden text-left transition-all transform bg-white divide-y divide-gray-300 rounded-lg shadow-xl sm:max-w-lg"
            >
              <div class="px-4 py-4 sm:py-4 sm:px-4">
                <h1 class="m-0 mb-0 text-lg font-semibold text-gray-700">Blacklist a Client</h1>
              </div>

              <div class="px-4 py-4 space-y-4 sm:py-4 sm:px-4">
                <div class="flex-1 bg-white border border-gray-200 divide-y divide-gray-200 rounded-lg shadow">
                  <div class="px-4 py-2">
                    <p class="mb-0 text-base font-medium text-gray-700">
                      <%= if @client.user do %>
                        <%= full_name(@client.user) %>
                      <% else %>
                        <%= @client.business.name %>
                      <% end %>
                    </p>
                    <p class="text-sm font-normal text-gray-500">
                      <%= if @client.user do %>
                        <%= "#{@client.user.id_number}, #{@client.user.email}" %>
                      <% else %>
                        <%= "#{@client.business.registration_number}, N/A" %>
                      <% end %>
                    </p>
                  </div>
                  <div class="px-4 py-2">
                    <p class="text-sm font-normal text-gray-500">
                      Not the User?
                      <span
                        phx-target={@myself}
                        phx-click="reset_blacklist_client"
                        class="font-semibold text-red-500 cursor-pointer"
                      >
                        Cancel
                      </span>
                    </p>
                  </div>
                </div>

                <div class="col-span-full">
                  <label for="reason" class="block text-sm font-medium leading-6 text-gray-700">
                    Enter reason for blacklisting
                  </label>
                  <div class="mt-2">
                    <textarea
                      id="reason"
                      name="reason"
                      rows="3"
                      class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                    ></textarea>
                  </div>
                </div>
              </div>

              <div class="flex items-center justify-end px-4 py-4 sm:py-4 sm:px-4">
                <div class="sm:space-x-1">
                  <button
                    phx-click="toggle_blacklist_modal"
                    type="button"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md shadow-sm hover:text-gray-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-white border rounded-md shadow-sm border-primary-500 bg-primary-500 hover:text-white hover:bg-primary-600 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Blacklist Client
                  </button>
                </div>
              </div>
            </form>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("reset_blacklist_client", _, socket) do
    {:noreply,
     socket
     |> assign(client: nil)}
  end

  def handle_event("validate_search", form_params, socket) do
    form =
      form_params
      |> search_changeset()
      |> to_form(as: "form")

    {:noreply, assign(socket, client_id_search_form: form)}
  end

  def handle_event("search_client", %{"form" => %{"client_id" => client_id}}, socket) do
    client =
      case client_id do
        "" -> nil
        _ -> Brs.Accounts.get_account(client_id)
      end

    {:noreply, assign(socket, :client, client)}
  end

  def handle_event("save", %{"reason" => _reason}, socket) do
    current_registry = socket.assigns.current_registry

    {:noreply,
     socket
     |> put_flash(:info, "Client Blacklisted successfully")
     |> push_navigate(to: ~p"/admin/registries/#{current_registry.slug}/clients")}
  end

  defp assign_form(socket) do
    changeset = search_changeset()

    assign(socket, :client_id_search_form, to_form(changeset, as: "form"))
  end

  defp search_changeset(params \\ %{}) do
    data_types = %{client_id: :string}

    {%{}, data_types}
    |> Ecto.Changeset.cast(params, Map.keys(data_types))
  end
end
