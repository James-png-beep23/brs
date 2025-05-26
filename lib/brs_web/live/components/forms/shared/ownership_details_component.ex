defmodule BrsWeb.Forms.OwnershipDetailsComponent do
  alias Brs.Helpers
  use BrsWeb, :live_component
  import Phoenix.HTML.Form

  @impl true
  def update(%{new_shareholder: new_shareholder} = assigns, socket) do
    # Update the list of shareholders in the form
    shareholders =
      case assigns[:index] do
        nil ->
          [
            new_shareholder | socket.assigns.form_data["shareholders"] || []
          ]

        index ->
          socket.assigns.form_data["shareholders"]
          |> then(fn list ->
            if is_list(list),
              do: List.update_at(list, String.to_integer(index), fn _ -> new_shareholder end),
              else: []
          end)
      end

    form_data =
      Map.get(socket.assigns, :form_data)
      |> Map.merge(%{"shareholders" => shareholders})

    form =
      %Brs.Forms.PlcSchema.Ownership{}
      |> Brs.Forms.PlcSchema.Ownership.changeset(form_data)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form(as: "form")

    {:ok, assign(socket, assigns |> Map.put(:form, form)) |> assign(shareholder_modal: false)}
  end

  @impl true
  def update(%{new_beneficial_owner: new_beneficial_owner} = assigns, socket) do
    beneficial_owners =
      case assigns[:index] do
        nil ->
          [
            new_beneficial_owner | socket.assigns.form_data["beneficial_owners"] || []
          ]

        index ->
          socket.assigns.form_data["beneficial_owners"]
          |> then(fn list ->
            if is_list(list),
              do:
                List.update_at(list, String.to_integer(index), fn _ -> new_beneficial_owner end),
              else: []
          end)
      end

    form_data =
      Map.get(socket.assigns, :form_data)
      |> Map.merge(%{"beneficial_owners" => beneficial_owners})

    form =
      %Brs.Forms.PlcSchema.Ownership{}
      |> Brs.Forms.PlcSchema.Ownership.changeset(form_data)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form(as: "form")

    {:ok,
     assign(socket, assigns |> Map.put(:form, form)) |> assign(beneficial_owner_modal: false)}
  end

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    changeset =
      socket.assigns.form.data
      |> Brs.Forms.PlcSchema.Ownership.changeset(socket.assigns.form.params)

    if changeset.valid? do
      # Notify the parent component
      form_data =
        changeset
        |> Ecto.Changeset.apply_changes()
        |> Helpers.struct_to_map()
        |> Helpers.stringify_keys()

      send(self(), {:save_draft, form_data})

      {:ok, assign(socket, assigns)}
    else
      form =
        changeset
        |> Map.put(:action, :validate)
        |> to_form(as: "form")

      {:ok, assign(socket, assigns) |> assign(:form, form)}
    end
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(shareholder_modal: false)
     |> assign(beneficial_owner_modal: false)
     |> assign_form()}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="px-4">
        <div class="mb-4">
          <h4 class="text-base font-semibold">Ownership Details</h4>
        </div>

        <div>
          <!-- Section: Certified Company Secretary Notice -->
          <div class="mb-5 mt-4">
            <div class="bg-blue-100 border border-blue-300 text-blue-800 text-sm font-bold px-3 py-2 rounded">
              Kindly note that you will be required to have a certified company secretary if your company has a paid-up share capital of 5,000,000 and above.
            </div>
          </div>
          <!-- Section: Director and Shareholder Notice -->
          <div class="mb-5">
            <div class="bg-blue-100 border border-blue-300 text-blue-800 text-sm font-bold px-3 py-2 rounded">
              You must appoint at least one director and one shareholder.
            </div>
          </div>
        </div>
        <.form :let={form} for={@form} phx-change="validate" phx-target={@myself}>
          <!-- Section: Owners -->
          <div class="mb-6">
            <h5 class="block text-base font-semibold text-gray-900 mb-2">Owners</h5>
            <div class="flow-root">
              <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                  <div class="overflow-hidden shadow ring-1 ring-black/5 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-gray-300">
                      <thead class="bg-gray-100">
                        <tr>
                          <th
                            scope="col"
                            class="py-3 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6"
                          >
                            ID Number
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                          >
                            Name
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                          >
                            ID Type
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                          >
                            Designation
                          </th>
                          <th scope="col" class="relative py-3 pl-3 pr-4 sm:pr-6">
                            <span class="sr-only">Edit</span>
                          </th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-200 bg-white">
                        <.inputs_for :let={owner} field={@form[:shareholders]}>
                          <tr>
                            <td class="whitespace-nowrap py-3.5 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                              <%= input_value(owner, :id_number) %>
                            </td>
                            <td class="whitespace-nowrap px-3 py-3.5 text-sm tID Numberext-gray-500">
                              <%= "#{input_value(owner, :first_name)} #{input_value(owner, :last_name)}" %>
                            </td>
                            <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-600">
                              <%= input_value(owner, :id_type) %>
                            </td>
                            <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-600">
                              <%= humanize(input_value(owner, :designation)) %>
                            </td>
                            <td class="relative whitespace-nowrap space-x-1 py-3.5 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                              <button
                                type="button"
                                phx-click="shareholder"
                                phx-target={@myself}
                                phx-value-shareholder_modal={true}
                                phx-value-owner_index={owner.index}
                                class="rounded-md bg-primary px-2.5 py-1.5 text-sm font-semibold text-white hover:bg-primary-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary"
                              >
                                Edit
                              </button>
                              <button
                                type="button"
                                phx-click="remove-shareholder"
                                phx-value-index={owner.index}
                                phx-target={@myself}
                                class="rounded-md bg-primary-700 px-2.5 py-1.5 text-sm font-semibold text-white hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600"
                              >
                                Remove
                              </button>
                            </td>
                          </tr>
                        </.inputs_for>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <div class="overflow-x-auto">
              <hr class="my-4 border-gray-300" />
              <div class="text-right">
                <button
                  type="button"
                  phx-click="shareholder"
                  phx-target={@myself}
                  phx-value-shareholder_modal={true}
                  phx-value-owner_index={nil}
                  class="bg-primary-600 hover:bg-primary-400 text-white font-medium py-2 px-4 text-sm rounded-md shadow-sm focus:outline-none"
                >
                  Add Director/Shareholder
                </button>
              </div>
            </div>
          </div>
          <!-- Section: Beneficial Owner -->
          <div class="mb-6">
            <h5 class="block text-base font-semibold text-gray-900 mb-2">Beneficial Owner</h5>
            <div>
              <div class="flow-root">
                <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                  <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                    <div class="overflow-hidden shadow ring-1 ring-black/5 sm:rounded-lg">
                      <table class="min-w-full divide-y divide-gray-300">
                        <thead class="bg-gray-100">
                          <tr>
                            <th
                              scope="col"
                              class="py-3 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6"
                            >
                              ID Number
                            </th>
                            <th
                              scope="col"
                              class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                            >
                              Name
                            </th>
                            <th
                              scope="col"
                              class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                            >
                              ID Type
                            </th>
                            <th
                              scope="col"
                              class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                            >
                              Designation
                            </th>
                            <th scope="col" class="relative py-3 pl-3 pr-4 sm:pr-6">
                              <span class="sr-only">Edit</span>
                            </th>
                          </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 bg-white">
                          <.inputs_for :let={owner} field={@form[:beneficial_owners]}>
                            <tr>
                              <td class="whitespace-nowrap py-3.5 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                                <%= input_value(owner, :id_number) %>
                              </td>
                              <td class="whitespace-nowrap px-3 py-3.5 text-sm tID Numberext-gray-500">
                                <%= "#{input_value(owner, :first_name)} #{input_value(owner, :last_name)}" %>
                              </td>
                              <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-600">
                                <%= input_value(owner, :id_type) %>
                              </td>
                              <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-600">
                                <%= input_value(owner, :designation) %>
                              </td>
                              <td class="relative whitespace-nowrap space-x-1 py-3.5 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                                <button
                                  type="button"
                                  phx-click="beneficial-owner"
                                  phx-target={@myself}
                                  phx-value-beneficial_owner_modal={true}
                                  phx-value-owner_index={owner.index}
                                  class="rounded-md bg-primary px-2.5 py-1.5 text-sm font-semibold text-white hover:bg-primary-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary"
                                >
                                  Edit
                                </button>
                                <button
                                  type="button"
                                  phx-click="remove-beneficial-owner"
                                  phx-value-index={owner.index}
                                  phx-target={@myself}
                                  class="rounded-md bg-primary-700 px-2.5 py-1.5 text-sm font-semibold text-white hover:bg-red-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600"
                                >
                                  Remove
                                </button>
                              </td>
                            </tr>
                          </.inputs_for>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              <hr class="my-4 border-gray-300" />
              <div class="text-right">
                <button
                  type="button"
                  phx-click="beneficial-owner"
                  phx-target={@myself}
                  phx-value-beneficial_owner_modal={true}
                  phx-value-owner_index={nil}
                  class="bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 text-sm rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2"
                >
                  Add Beneficial Owner
                </button>
              </div>
            </div>
          </div>
          <!-- Section: Type of Secretary -->
          <div class="mb-6">
            <label for="type_of_secretary" class="block text-sm font-semibold text-gray-900">
              Type of Secretary
            </label>
            <div class="mt-1">
              <select
                id="type_of_secretary"
                name={input_name(form, :type_of_secretary)}
                class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option value="">Choose...</option>
                <option
                  selected={input_value(form, :type_of_secretary) == "secretary"}
                  value="secretary"
                >
                  Secretary
                </option>
                <option
                  selected={input_value(form, :type_of_secretary) == "joint_secretary"}
                  value="joint_secretary"
                >
                  Joint Secretary
                </option>
              </select>
              <%= error_tag(form, :type_of_secretary) %>
            </div>
          </div>
        </.form>
        <.modal
          :if={@shareholder_modal}
          id="share-holder-modal"
          show
          on_cancel={JS.push("shareholder", value: %{shareholder_modal: false}, target: @myself)}
        >
          <.live_component
            id="share-holder"
            module={BrsWeb.Forms.ShareholderComponent}
            form_data={@form_data}
            owner_index={@owner_index}
          />
        </.modal>

        <.modal
          :if={@beneficial_owner_modal}
          id="beneficial-owner-modal"
          show
          on_cancel={
            JS.push("beneficial-owner", value: %{beneficial_owner_modal: false}, target: @myself)
          }
        >
          <.live_component
            id="beneficial-owner"
            module={BrsWeb.Forms.BeneficialOwnerComponent}
            form_data={@form_data}
            owner_index={@owner_index}
          />
        </.modal>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("shareholder", %{"shareholder_modal" => shareholder_modal} = params, socket) do
    {:noreply,
     socket
     |> assign(shareholder_modal: shareholder_modal)
     |> assign(owner_index: params["owner_index"])}
  end

  @impl true
  def handle_event(
        "beneficial-owner",
        %{"beneficial_owner_modal" => beneficial_owner_modal} = params,
        socket
      ) do
    {:noreply,
     socket
     |> assign(beneficial_owner_modal: beneficial_owner_modal)
     |> assign(owner_index: params["owner_index"])}
  end

  @impl true
  def handle_event("validate", %{"form" => params}, socket) do
    params =
      params
      |> Map.put("shareholders", socket.assigns.form_data["shareholders"] || [])
      |> Map.put("beneficial_owners", socket.assigns.form_data["beneficial_owners"] || [])

    form =
      socket.assigns.form.data
      |> Brs.Forms.PlcSchema.Ownership.changeset(params)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form(action: :validate, as: "form")

    {:noreply, socket |> assign(:form, form)}
  end

  def handle_event("remove-shareholder", %{"index" => index}, socket) do
    socket =
      socket.assigns[:form_data]["shareholders"]
      |> update_in(fn
        list when is_list(list) -> List.delete_at(list, String.to_integer(index))
        [] -> []
      end)

    form =
      socket.assigns.form.data
      |> Brs.Forms.PlcSchema.Ownership.changeset(socket.assigns.form_data)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form(action: :validate, as: "form")

    {:noreply, socket |> assign(:form, form)}
  end

  def handle_event("remove-beneficial-owner", %{"index" => index}, socket) do
    socket =
      socket.assigns[:form_data]["beneficial_owners"]
      |> update_in(fn
        list when is_list(list) -> List.delete_at(list, String.to_integer(index))
        [] -> []
      end)

    form =
      socket.assigns.form.data
      |> Brs.Forms.PlcSchema.Ownership.changeset(socket.assigns.form_data)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form(action: :validate, as: "form")

    {:noreply, socket |> assign(:form, form)}
  end

  defp assign_form(socket) do
    form_data = socket.assigns[:form_data] || %{}

    form =
      %Brs.Forms.PlcSchema.Ownership{}
      |> Brs.Forms.PlcSchema.Ownership.changeset(form_data)
      |> to_form(as: "form")

    assign(socket, :form, form)
  end
end
