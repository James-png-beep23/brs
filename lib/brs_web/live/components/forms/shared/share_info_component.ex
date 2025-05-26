defmodule BrsWeb.Forms.ShareInfoComponent do
  alias Brs.Forms.PlcSchema.ShareInformation
  use BrsWeb, :live_component
  import Phoenix.HTML.Form

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    form = socket.assigns.form

    changeset =
      form.data
      |> ShareInformation.changeset(form.params)

    if changeset.valid? do
      # Notify the parent component
      share_info =
        changeset
        |> Ecto.Changeset.apply_changes()
        |> Map.from_struct()
        |> Map.update!(:shares, fn shares -> Enum.map(shares, &Map.from_struct/1) end)

      send(self(), {:save_draft, %{"share_information" => share_info}})

      {:ok, assign(socket, assigns)}
    else
      form =
        changeset
        |> Map.put(:action, :validate)
        |> to_form(as: "form")

      {:ok, assign(socket, assigns) |> assign(:form, form)}
    end
  end

  def update(assigns, socket) do
    form_data = Map.get(assigns, :form_data)

    {changeset, total_number_of_shares, total_nominal_capital, selected_share_categories} =
      case form_data do
        %{"share_information" => params} ->
          changeset = ShareInformation.changeset(%ShareInformation{}, params)
          {total_shares, total_capital, selected_categories} = initialize_shares_totals(params)

          {changeset, total_shares, total_capital, selected_categories}

        _ ->
          {ShareInformation.changeset(%ShareInformation{}), 0, 0, []}
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       total_number_of_shares: total_number_of_shares,
       total_nominal_capital: total_nominal_capital,
       selected_share_categories: selected_share_categories
     )
     |> assign_form(changeset)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <h4 class="text-base md:text-lg font-semibold text-gray-900 mb-4">
        <span>Share Information</span>
      </h4>
      <div class="flex flex-wrap gap-4">
        <!-- Total Shares Available For Distribution -->
        <div class="flex-1 w-full min-w-[300px]">
          <div class="mb-6">
            <label
              for="TotalSharesAvailableForDistribution"
              class="block text-sm font-medium text-gray-700"
            >
              Total Shares Available For Distribution <span class="text-red-500">*</span>
            </label>
            <div class="bg-white shadow-md rounded-lg px-4">
              <ul class="divide-y divide-gray-200">
                <.form
                  id="share-information-form"
                  for={@form}
                  phx-target={@myself}
                  phx-change="validate_share_information"
                >
                  <%= error_tag(@form, :shares) %>
                  <input type="hidden" name="[form][shares_drop][]" />
                  <.inputs_for :let={share} field={@form[:shares]}>
                    <input type="hidden" name="form[shares_sort][]" value={share.index} />
                    <!-- Share Category -->
                    <li class="py-5">
                      <div class="grid grid-col-1 sm:grid-col-2 lg:grid-cols-3 gap-4">
                        <div>
                          <label for="shareCategory" class="block text-sm font-medium text-gray-700">
                            Share Category
                          </label>
                          <div class="relative">
                            <select
                              id={"shareCategory-#{share.index}"}
                              name={input_name(share, :category)}
                              class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
                              aria-label="Search for option"
                            >
                              <option disabled selected>Select...</option>
                              <option
                                value="ORDINARY"
                                disabled={
                                  @selected_share_categories &&
                                    "ORDINARY" in @selected_share_categories &&
                                    input_value(share, :category) != "ORDINARY"
                                }
                                selected={input_value(share, :category) == "ORDINARY"}
                              >
                                ORDINARY
                              </option>
                              <option
                                value="PREFERENCE"
                                disabled={
                                  @selected_share_categories &&
                                    "PREFERENCE" in @selected_share_categories &&
                                    input_value(share, :category) != "PREFERENCE"
                                }
                                selected={input_value(share, :category) == "PREFERENCE"}
                              >
                                PREFERENCE
                              </option>
                              <option
                                value="OTHER"
                                selected={input_value(share, :category) == "OTHER"}
                              >
                                OTHER
                              </option>
                            </select>
                          </div>
                        </div>
                        <div>
                          <label for="numberOfShares" class="block text-sm font-medium text-gray-700">
                            Number Of Shares
                          </label>
                          <input
                            type="number"
                            id={"numberOfShares-#{share.index}"}
                            name={input_name(share, :number)}
                            value={input_value(share, :number)}
                            class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500 mt-1"
                          />
                          <%= error_tag(share, :number) %>
                        </div>
                        <div>
                          <label
                            for="valueOfEachShare"
                            class="block text-sm font-medium text-gray-700"
                          >
                            Value Of Each Share
                          </label>
                          <input
                            type="number"
                            id="valueOfEachShare"
                            name={input_name(share, :nominal_value)}
                            value={input_value(share, :nominal_value)}
                            min="0"
                            class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500 mt-1"
                          />
                          <%= error_tag(share, :nominal_value) %>
                        </div>
                      </div>
                    </li>
                    <!-- Other Share Category Name -->
                    <li :if={input_value(share, :category) == "OTHER"} class="py-5">
                      <div>
                        <label for="otherCategory" class="block text-sm font-medium text-gray-700">
                          Other Share Category Name
                        </label>
                        <input
                          type="text"
                          id="otherCategory"
                          name={input_name(share, :other)}
                          class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                        />
                        <span class="text-red-500 text-sm">
                          This is required when category is 'OTHER'
                        </span>
                      </div>
                    </li>
                    <!-- Nominal Capital -->
                    <li class="py-5">
                      <div>
                        <label for="nominalCapital" class="block text-sm font-medium text-gray-700">
                          Nominal Capital
                        </label>
                        <input
                          type="number"
                          id="nominalCapital"
                          value={@total_nominal_capital}
                          disabled
                          class="mt-1 block w-full bg-gray-100 border border-gray-300 rounded-md shadow-sm py-2 px-3 sm:text-sm"
                        />
                      </div>
                    </li>
                  </.inputs_for>
                  <!-- Total Nominal Capital and Shares -->
                  <li class="py-5">
                    <div class="grid grid-cols-2 gap-4">
                      <div>
                        <label class="block text-sm font-medium text-gray-700">
                          Total Nominal Capital
                        </label>
                        <h4 class="text-lg font-semibold"><%= @total_nominal_capital %></h4>
                      </div>
                      <div>
                        <label class="block text-sm font-medium text-gray-700">
                          Total Shares
                        </label>
                        <h4 class="text-lg font-semibold"><%= @total_number_of_shares %></h4>
                      </div>
                    </div>
                  </li>
                  <!-- Add Share Category -->
                  <li class="py-5 text-center">
                    <button
                      type="button"
                      name="form[shares_sort][]"
                      value="new"
                      phx-click={JS.dispatch("change")}
                      class="mt-3 inline-flex justify-center px-4 py-2 bg-green-600 text-white font-medium text-sm leading-5 rounded-md shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
                    >
                      Add Share Category
                    </button>
                  </li>
                </.form>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("validate_share_information", %{"form" => form_params} = _params, socket) do
    form =
      socket.assigns.form.source.data
      |> ShareInformation.changeset(form_params)
      |> to_form(action: :validate, as: "form")

    selected_share_categories = get_selected_categories(form)

    {:noreply,
     socket
     |> assign(:form, form)
     |> assign(:selected_share_categories, selected_share_categories)
     |> assign_totals(form)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: "form"))
  end

  defp initialize_shares_totals(params) do
    shares = Map.get(params, "shares", %{})

    valid_shares =
      shares
      |> Enum.map(fn share -> share end)
      |> Enum.filter(fn share -> share["nominal_value"] != "" and share["number"] != "" end)

    total_number_of_shares =
      valid_shares
      |> Enum.map(& &1["number"])
      |> Enum.sum()

    total_nominal_capital =
      valid_shares
      |> Enum.map(fn share ->
        String.to_integer(share["nominal_value"]) * share["number"]
      end)
      |> Enum.sum()

    selected_share_categories =
      valid_shares
      |> Enum.map(& &1["category"])
      |> Enum.uniq()

    {total_number_of_shares, total_nominal_capital, selected_share_categories}
  end

  defp get_selected_categories(form) do
    shares = form.source.changes[:shares] || []

    shares
    |> Enum.map(fn share_changeset -> share_changeset.changes[:category] end)
    |> Enum.filter(& &1)
  end

  defp assign_totals(socket, form) do
    shares = form.source.changes[:shares] || []

    {total_number_of_shares, total_nominal_capital} =
      shares
      |> Enum.reduce({0, Decimal.new(0)}, fn share_changeset, {total_shares, total_capital} ->
        changes = share_changeset.changes

        number = Map.get(changes, :number, 0)
        nominal_value = Map.get(changes, :nominal_value, Decimal.new(0))

        {
          total_shares + number,
          Decimal.add(total_capital, Decimal.mult(Decimal.new(number), nominal_value))
        }
      end)

    params =
      Map.merge(form.params, %{
        "total_shares" => total_number_of_shares,
        "total_nominal_capital" => total_nominal_capital |> Decimal.to_float()
      })

    form =
      socket.assigns.form.source.data
      |> ShareInformation.changeset(params)
      |> to_form(action: :validate, as: "form")

    assign(socket,
      total_number_of_shares: total_number_of_shares,
      total_nominal_capital: total_nominal_capital
    )
    |> assign(:form, form)
  end
end
