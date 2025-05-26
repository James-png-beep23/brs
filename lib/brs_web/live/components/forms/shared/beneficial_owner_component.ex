defmodule BrsWeb.Forms.BeneficialOwnerComponent do
  use BrsWeb, :live_component
  alias Brs.Forms.BeneficialOwner
  alias Brs.Helpers

  import Phoenix.HTML.Form

  @impl true
  def mount(socket) do
    changeset = BeneficialOwner.changeset(%BeneficialOwner{})
    {:ok, assign(socket, :form, to_form(changeset)) |> assign(shares: "")}
  end

  @impl true
  def update(%{owner_index: owner_index} = assigns, socket) when not is_nil(owner_index) do
    beneficial_owner =
      Enum.at(assigns.form_data["beneficial_owners"], String.to_integer(owner_index))

    changeset =
      %BeneficialOwner{}
      |> BeneficialOwner.changeset(beneficial_owner)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()

    {:ok,
     assign(socket, :form, to_form(changeset))
     |> assign(assigns)}
  end

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="pt-5">
      <.form :let={form} for={@form} phx-change="validate" phx-submit="save" phx-target={@myself}>
        <div class="w-full mb-4">
          <label for="designation" class="block text-sm font-semibold text-gray-900">
            Designation <span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
          </label>
          <div class="mt-1">
            <select
              id="designation"
              name={input_name(form, :designation)}
              aria-label="Designation"
              aria-required="true"
              required
              class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
            >
              <option value="">Choose...</option>
              <option
                selected={input_value(form, :designation) == "director_shareholder"}
                value="director_shareholder"
              >
                Director Shareholder
              </option>
              <option selected={input_value(form, :designation) == "shareholder"} value="shareholder">
                Shareholder
              </option>
              <option selected={input_value(form, :designation) == "director"} value="director">
                Director
              </option>
            </select>
            <%= error_tag(form, :designation) %>
          </div>
          <div class="mt-1">
            <.input
              type="select"
              field={form[:id_type]}
              label="ID Type"
              options={[
                {"Choose...", nil},
                {"Kenyan Citizen", "citizen"},
                {"Foreign Resident", "alien"},
                {"Foreigner", "visitor"},
                {"Local Company", "local_company"},
                {"Foreign Legal Persons", "foreign_company"},
                {"Other Legal Persons", "other"}
              ]}
              required
            />
          </div>
        </div>
        <div :if={input_value(@form, :id_type) not in [nil, ""]}>
          <div class="grid grid-cols-2 gap-4">
            <div class="col-span-2">
              <.input type="text" field={@form[:id_number]} label="ID Number" />
            </div>
            <div class="">
              <.input type="text" field={@form[:first_name]} label="First Name" />
            </div>
            <div class="">
              <.input type="text" field={@form[:middle_name]} label="Middle Name" />
            </div>
            <div class="col-span-2">
              <.input type="text" field={@form[:last_name]} label="Last Name" />
            </div>
            <div class="">
              <.input type="text" field={@form[:date_of_birth]} label="Date Of Birth" />
            </div>
            <div class="">
              <.input type="text" field={@form[:gender]} label="Gender" />
            </div>
            <div class="">
              <.input type="text" field={@form[:kra_pin]} label="KRA Pin Number" />
            </div>
            <div class="">
              <.input type="text" field={@form[:full_name]} label="Former Name(if any)" />
            </div>
            <div class="">
              <.input type="text" field={@form[:passport_photo]} label="Passport Photo" />
            </div>
          </div>
          <div>
            <h4 class="uppercase">Contacts</h4>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div class="">
              <.input type="text" field={@form[:phone_number]} label="Phone Number" />
            </div>
            <div class="">
              <.input type="text" field={@form[:email]} label="Email" />
            </div>
            <div class="">
              <.input type="text" field={@form[:postal_address]} label="Postal Address" />
            </div>
            <div class="">
              <.input type="text" field={@form[:postal_code]} label="Postal Code" />
            </div>
            <div class="">
              <.input
                type="text"
                field={@form[:service_address]}
                label="Service Address (if different from above address)"
              />
            </div>
            <div class="">
              <.input type="text" field={@form[:occupation]} label="Occupation" />
            </div>
          </div>
        </div>

        <div class="flex flex-wrap w-full">
          <h4 class="w-full flex justify-between items-center mb-2">
            <div>
              <span class="text-base font-semibold text-gray-900">
                Residential / Registered Address
              </span>
            </div>
          </h4>

          <div class="text-sm text-gray-500 mb-4 w-full"><hr /></div>

          <div>
            <div class="grid grid-cols-2 gap-4 mb-5">
              <!-- Name of building/Plot No./Estate and House No. -->
              <div>
                <label for="name-of-building" class="block text-sm font-semibold text-gray-900">
                  Name of building/Plot No./Estate and House No.<span
                    aria-hidden="true"
                    class="text-red-500 inline-block pl-1"
                  >*</span>
                </label>
                <div class="mt-1">
                  <.input
                    type="text"
                    field={form[:building]}
                    id="name-of-building"
                    aria-required="true"
                    aria-label="Name of building/Plot No./Estate and House No."
                    placeholder="Enter details"
                    class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                  />
                </div>
              </div>
              <!-- Street/Road -->
              <div>
                <label for="Street/Road" class="block text-sm font-semibold text-gray-900">
                  Street/Road<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
                </label>
                <div class="mt-1">
                  <input
                    type="text"
                    name="Street/Road"
                    id="Street/Road"
                    aria-required="true"
                    aria-label="Enter street/road"
                    placeholder="Enter street/road"
                    class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                  />
                </div>
              </div>
              <!-- Floor -->
              <div>
                <label for="first-name" class="block text-sm font-semibold text-gray-900">
                  Floor
                </label>
                <div class="mt-1">
                  <input
                    type="text"
                    name="Floor"
                    id="Floor"
                    aria-required="true"
                    aria-label="Enter floor"
                    placeholder="Enter floor"
                    class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                  />
                </div>
              </div>
              <!-- Room/Door No -->
              <div>
                <label for="first-name" class="block text-sm font-semibold text-gray-900">
                  Room/Door No
                </label>
                <div class="mt-1">
                  <input
                    type="text"
                    name="Room/Door No"
                    id="Room/Door No"
                    aria-required="true"
                    aria-label="Enter room/door no."
                    placeholder="Enter room/door no."
                    class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-blue-100 text-primary-800 px-3 py-2 rounded mb-5">
          <h6 class="font-semibold text-sm">
            All shares must be paid up where the company has adopted model of articles
          </h6>
        </div>

        <div class="flex flex-wrap w-full">
          <h5 class="text-base font-semibold text-gray-900 mb-3">Share information</h5>

          <div class="p-4 border border-1 rounded-md">
            <ul class="list-group">
              <!-- Name Section -->
              <li class="list-group-item">
                <div class="flex flex-col">
                  <label class="block text-base font-semibold text-gray-900 mb-2">Name</label>
                  <div>
                    <h4 class="text-lg"><%= form.data.first_name %></h4>
                  </div>
                </div>
              </li>
              <!-- Shares Section -->
              <li class="list-group-item table-responsive">
                <div class="bg-gray-100 p-2 border rounded mb-2 space-x-3 flex justify-between">
                  <label class="font-bold text-base text-gray-900">Shares</label>
                  <span class="text-green-600 text-base">
                    <%= form.data.share_information && form.data.share_information.percentage %>%
                  </span>
                </div>

                <div class="mb-3">
                  <%= for {share, index} <- Enum.with_index(@form_data["share_information"] && @form_data["share_information"]["shares"] || []) do %>
                    <div class="flex flex-col bg-gray-100 p-2 border rounded mb-2">
                      <label>Category</label>
                      <div class="flex justify-between w-full">
                        <h5 class="font-bold text-base text-gray-900"><%= share["category"] %></h5>
                        <label class="text-green-600 text-base">
                          <% share_info =
                            (form.data.share_information && form.data.share_information.shares) || []

                          category_share =
                            Enum.find(share_info, fn item -> item.name == share["category"] end)

                          percentage =
                            (category_share && Map.get(category_share, :percentage, 0)) || 0 %>

                          <%= percentage %>%
                        </label>
                      </div>
                    </div>

                    <div class="mt-2 flow-root">
                      <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                        <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                          <table class="min-w-full divide-y divide-gray-300">
                            <thead>
                              <tr>
                                <th
                                  scope="col"
                                  class="py-3 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0"
                                >
                                  No. of shares allocated
                                </th>
                                <th
                                  scope="col"
                                  class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                                >
                                  Shares Paid Up
                                </th>
                                <th
                                  scope="col"
                                  class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                                >
                                  Shares UnPaid
                                </th>
                                <th scope="col" class="relative py-3 pl-3 pr-4 sm:pr-0">
                                  <span class="sr-only">Available Shares</span>
                                </th>
                              </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                              <%= if category_share do %>
                                <tr>
                                  <td class="whitespace-nowrap py-4 pl-3.5 pr-3 text-sm font-medium text-gray-900 sm:pl-0">
                                    <%= category_share.issued %>
                                  </td>
                                  <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-900">
                                    <%= category_share.shares_paidup %>
                                  </td>
                                  <td class="whitespace-nowrap px-3 py-3.5 text-sm text-gray-900">
                                    0
                                  </td>
                                </tr>
                              <% end %>
                            </tbody>
                          </table>
                          <div class="flex flex-wrap mt-2">
                            <hr />
                            <label class="px-2">Allocations</label>
                            <div class="w-full mb-4">
                              <input
                                id={"shares-#{index}"}
                                type="text"
                                name="shares"
                                placeholder="Enter Quantity"
                                class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                              />
                            </div>
                            <div class="flex space-x-4">
                              <button
                                id={"btn-issue-shares-#{index}"}
                                type="button"
                                phx-target={@myself}
                                data-index={index}
                                data-category={share["category"]}
                                phx-hook="AllocateShares"
                                class="bg-transparent hover:bg-blue-400 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-400 hover:border-transparent rounded"
                              >
                                Issue Shares
                              </button>
                              <button
                                type="button"
                                id={"btn-cancel-shares-#{index}"}
                                phx-target={@myself}
                                phx-click="cancel-shares"
                                phx-value-category={share["category"]}
                                class="bg-transparent hover:bg-yellow-400 text-yellow-700 font-semibold hover:text-white py-2 px-4 border border-yellow-400 hover:border-transparent rounded"
                              >
                                Cancel
                              </button>
                            </div>
                            <div class="clearfix"></div>
                            <hr />
                          </div>
                        </div>
                      </div>
                    </div>
                  <% end %>
                </div>
              </li>
              <!-- Beneficial Ownership Section -->
              <li class="list-group-item table-responsive">
                <div class="bg-gray-100 p-2 border rounded mb-2 space-x-3 flex justify-between mb-4">
                  <label class="font-bold text-base text-gray-900">Beneficial Ownership</label>
                </div>
                <div class="grid grid-cols-3 gap-3">
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Total Ownership (%)
                    </label>
                    <input
                      readonly
                      value={form.data.share_information && form.data.share_information.percentage}
                      disabled
                      class="block w-full rounded-md bg-gray-200 px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Direct Ownership - Max <%= form.data.share_information &&
                        form.data.share_information.percentage %>%
                    </label>
                    <input
                      type="number"
                      name={input_name(form, :share_information) <> "[direct_shareownership]"}
                      value={Map.get(form.data.share_information || %{}, :direct_shareownership, "")}
                      phx-value-max={
                        form.data.share_information && form.data.share_information.percentage
                      }
                      class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                    <.inputs_for :let={sub_form} field={form[:share_information]}>
                      <%= error_tag(sub_form, :direct_shareownership) %>
                    </.inputs_for>
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Indirect Ownership (%)
                    </label>
                    <input
                      readonly
                      disabled
                      class="block w-full rounded-md bg-gray-200 px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                  </div>
                </div>
                <div class="grid grid-cols-3 gap-3 mt-4">
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Total Voting Rights - Max 100%
                    </label>
                    <input
                      type="number"
                      name={input_name(form, :share_information) <> "[total_voting_rights]"}
                      value={Map.get(form.data.share_information || %{}, :total_voting_rights, "")}
                      class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Direct Voting Rights - Max 0%
                    </label>
                    <input
                      type="number"
                      name={input_name(form, :share_information) <> "[direct_voting_rights]"}
                      value={Map.get(form.data.share_information || %{}, :direct_voting_rights, "")}
                      class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Indirect Voting Rights (%)
                    </label>
                    <input
                      readonly
                      disabled
                      class="block w-full rounded-md bg-gray-200 px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                    />
                  </div>
                </div>
                <div class="grid grid-cols-2 gap-4 mt-4">
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Type of influence in the company
                    </label>
                    <select
                      name={input_name(form, :share_information) <> "[type_of_influence]"}
                      class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
                    >
                      <option value="">--None--</option>
                      <option
                        selected={
                          Map.get(form.data.share_information || %{}, :type_of_influence, "") ==
                            "direct"
                        }
                        value="direct"
                      >
                        Direct
                      </option>
                      <option
                        selected={
                          Map.get(form.data.share_information || %{}, :type_of_influence, "") ==
                            "indirect"
                        }
                        value="indirect"
                      >
                        Indirect
                      </option>
                    </select>
                  </div>
                  <div>
                    <label class="block text-sm font-semibold text-gray-900 mb-1">
                      Rights to appoint other directors
                    </label>
                    <select
                      name={input_name(form, :share_information) <> "[rights_to_appoint_directors]"}
                      class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
                    >
                      <option value="">--None--</option>
                      <option
                        selected={
                          Map.get(
                            form.data.share_information || %{},
                            :rights_to_appoint_directors,
                            ""
                          ) ==
                            "indirect"
                        }
                        value="direct"
                      >
                        Direct
                      </option>
                      <option
                        selected={
                          Map.get(
                            form.data.share_information || %{},
                            :rights_to_appoint_directors,
                            ""
                          ) ==
                            "indirect"
                        }
                        value="indirect"
                      >
                        Indirect
                      </option>
                    </select>
                  </div>
                </div>
                <!-- Indirect Share Ownership -->
                <div class="mt-4">
                  <div class="bg-gray-100 p-2 border rounded mb-2 space-x-3 flex justify-between mb-4">
                    <label class="font-bold text-base text-gray-900">Indirect Share Ownership</label>
                  </div>
                  <div class="mt-2 flow-root">
                    <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                      <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                        <table class="min-w-full divide-y divide-gray-300">
                          <thead>
                            <tr>
                              <th
                                scope="col"
                                class="py-3 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0"
                              >
                                Holder
                              </th>
                              <th
                                scope="col"
                                class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                              >
                                Value(%)
                              </th>

                              <th scope="col" class="relative py-3 pl-3 pr-4 sm:pr-0">
                                <span class="sr-only">Options</span>
                              </th>
                            </tr>
                          </thead>
                          <tbody class="divide-y divide-gray-200">
                            <tr>
                              <td class="whitespace-nowrap py-3 pl-3.5 pr-3 text-sm font-medium text-gray-900 sm:pl-0">
                                <%= form.data.share_information &&
                                  form.data.share_information.indirect_shares["share_holder_id"] %>
                              </td>
                              <td class="whitespace-nowrap px-3 py-3 text-sm text-gray-900">
                                <%= form.data.share_information &&
                                  form.data.share_information.indirect_shares["indirect_share"] %>
                              </td>
                              <td class="relative whitespace-nowrap py-3 pl-3 pr-4 text-right text-gray-900 text-sm font-medium sm:pr-0">
                              </td>
                            </tr>
                          </tbody>
                        </table>
                        <input
                          type="hidden"
                          name={input_name(form, :share_information) <> "[indirect_shares][share_holder_id]"}
                          value={
                            Map.get(form.data.share_information || %{}, :indirect_shares, %{})
                            |> Map.get("share_holder_id")
                          }
                        />
                        <input
                          type="hidden"
                          name={input_name(form, :share_information) <> "[indirect_shares][indirect_share]"}
                          value={
                            Map.get(form.data.share_information || %{}, :indirect_shares, %{})
                            |> Map.get("indirect_share")
                          }
                        />
                        <div id="indirect-share" class="hidden">
                          <table class="min-w-full divide-y divide-gray-300">
                            <tr>
                              <td class="whitespace-nowrap py-3 pl-4 pr-3 text-sm text-gray-900 sm:pl-0">
                                <select
                                  id="share_holder_id"
                                  name="share_holder_id"
                                  class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                                >
                                  <option value="Option 1">Option 1</option>
                                  <option value="Option 2">Option 2</option>
                                </select>
                              </td>

                              <td class="whitespace-nowrap px-3 py-3 text-sm text-gray-900">
                                <input
                                  id="indirect_share"
                                  type="number"
                                  phx-update="ignore"
                                  name="indirect_share"
                                  class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                                />
                              </td>

                              <td class="whitespace-nowrap py-3 pl-3 pr-4 text-right text-gray-900 text-sm font-medium sm:pr-0">
                                <button
                                  id="share-ownership"
                                  type="button"
                                  phx-click="add-share-ownership"
                                  phx-hook="ShareOwnerShip"
                                  phx-target={@myself}
                                  class="bg-primary-600 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-primary-600"
                                >
                                  Save
                                </button>

                                <button
                                  type="button"
                                  phx-click={
                                    JS.hide(to: "#indirect-share")
                                    |> JS.show(to: "#share-add-button")
                                  }
                                  class="bg-red-600 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-red-600"
                                >
                                  Cancel
                                </button>
                              </td>
                            </tr>
                          </table>
                        </div>
                        <button
                          id="share-add-button"
                          type="button"
                          phx-click={
                            JS.show(to: "#indirect-share") |> JS.hide(to: "#share-add-button")
                          }
                          class="btn-sm bg-primary-600 hover:bg-primary-400 text-white font-medium py-2 px-4 text-sm rounded-md shadow-sm focus:outline-none"
                        >
                          Add
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Indirect Voting Rights -->
                <div class="mt-4">
                  <div class="bg-gray-100 p-2 border rounded mb-2 space-x-3 flex justify-between mb-4">
                    <label class="font-bold text-base text-gray-900">Indirect Voting Rights</label>
                  </div>
                  <div class="mt-2 flow-root">
                    <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                      <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                        <table class="min-w-full divide-y divide-gray-300">
                          <thead>
                            <tr>
                              <th
                                scope="col"
                                class="py-3 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0"
                              >
                                Holder
                              </th>
                              <th
                                scope="col"
                                class="px-3 py-3 text-left text-sm font-semibold text-gray-900"
                              >
                                Value(%)
                              </th>
                              <th scope="col" class="relative py-3 pl-3 pr-4 sm:pr-0">
                                <span class="sr-only">Options</span>
                              </th>
                            </tr>
                          </thead>
                          <tbody class="divide-y divide-gray-200">
                            <tr>
                              <td class="whitespace-nowrap py-3 pl-3.5 pr-3 text-sm font-medium text-gray-900 sm:pl-0">
                                <%= form.data.share_information &&
                                  form.data.share_information.indirect_voting_rights["vote_holder"] %>
                              </td>
                              <td class="whitespace-nowrap px-3 py-3 text-sm text-gray-900">
                                <%= form.data.share_information &&
                                  form.data.share_information.indirect_voting_rights["indirect_votes"] %>
                              </td>
                              <td class="relative whitespace-nowrap py-3 pl-3 pr-4 text-right text-gray-900 text-sm font-medium sm:pr-0">
                              </td>
                            </tr>
                          </tbody>
                        </table>
                        <input
                          type="hidden"
                          name={input_name(form, :share_information) <> "[indirect_voting_rights][vote_holder]"}
                          value={
                            Map.get(form.data.share_information || %{}, :indirect_voting_rights, %{})
                            |> Map.get("vote_holder")
                          }
                        />
                        <input
                          type="hidden"
                          name={input_name(form, :share_information) <> "[indirect_voting_rights][indirect_votes]"}
                          value={
                            Map.get(form.data.share_information || %{}, :indirect_voting_rights, %{})
                            |> Map.get("indirect_votes")
                          }
                        />
                        <div id="indirect-voting" class="hidden">
                          <table class="min-w-full divide-y divide-gray-300">
                            <tr>
                              <td class="whitespace-nowrap py-3 pl-4 pr-3 text-sm text-gray-900 sm:pl-0">
                                <select
                                  id="vote-holder"
                                  name="vote-holder"
                                  class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                                >
                                  <option value="Option 1">Option 1</option>
                                  <option value="Option 2">Option 2</option>
                                </select>
                              </td>

                              <td class="whitespace-nowrap px-3 py-3 text-sm text-gray-900">
                                <input
                                  id="indirect-votes"
                                  type="number"
                                  name="indirect-votes"
                                  class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
                                />
                              </td>

                              <td class="whitespace-nowrap py-3 pl-3 pr-4 text-right text-gray-900 text-sm font-medium sm:pr-0">
                                <button
                                  id="vote-rights"
                                  type="button"
                                  phx-hook="ShareVoteRights"
                                  phx-target={@myself}
                                  class="bg-primary-600 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-primary-600"
                                >
                                  Save
                                </button>

                                <button
                                  type="button"
                                  phx-click={
                                    JS.hide(to: "#indirect-voting")
                                    |> JS.show(to: "#voting-add-button")
                                  }
                                  class="bg-red-600 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-red-600"
                                >
                                  Cancel
                                </button>
                              </td>
                            </tr>
                          </table>
                        </div>
                        <button
                          id="voting-add-button"
                          type="button"
                          phx-click={
                            JS.show(to: "#indirect-voting") |> JS.hide(to: "#voting-add-button")
                          }
                          class="btn-sm bg-primary-600 hover:bg-primary-400 text-white font-medium py-2 px-4 text-sm rounded-md shadow-sm focus:outline-none"
                        >
                          Add
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>

        <div>
          <div class="p-2 justify-start space-x-2 mt-2">
            <button class="bg-red-500 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-red-600">
              Cancel
            </button>
            <button
              type="submit"
              class="bg-green-500 text-white font-normal text-sm px-4 py-2 rounded shadow hover:bg-green-600"
            >
              Save
            </button>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event("validate", %{"beneficial_owner" => params}, socket) do
    updated_params = update_share_information(socket, params)

    changeset =
      socket.assigns.form.data
      |> BeneficialOwner.changeset(updated_params)
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> BeneficialOwner.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("save", %{"beneficial_owner" => params}, socket) do
    updated_params = update_share_information(socket, params)
    changeset = BeneficialOwner.changeset(socket.assigns.form.data, updated_params)

    if changeset.valid? do
      # Notify the parent component

      send_update(BrsWeb.Forms.OwnershipDetailsComponent,
        id: "form",
        new_beneficial_owner: updated_params,
        index: socket.assigns[:owner_index]
      )

      {:noreply, socket}
    else
      {:noreply, assign(socket, :form, to_form(changeset |> Map.put(:action, :validate)))}
    end
  end

  def handle_event("issue-shares", %{"shares" => shares, "category" => category}, socket) do
    share_info =
      socket.assigns.form_data["share_information"] || %{"total_shares" => 0, "shares" => []}

    total_shares = share_info["total_shares"]

    category_shares =
      share_info["shares"]
      |> Enum.find(&(&1["category"] == category))
      |> Map.get("number", 0)

    with {:ok, shares_number} <- parse_shares(shares),
         {:ok, percentage} <- calculate_percentage(total_shares, shares_number),
         {:ok, category_percentage} <- calculate_percentage(category_shares, shares_number) do
      params = %{
        percentage: percentage,
        shares: [
          %{
            name: category,
            issued: shares_number,
            shares_paidup: shares_number,
            shares_unpaid: 0,
            percentage: category_percentage
          }
        ]
      }

      form = update_form(socket, &Brs.Forms.ShareInformation.add_shares/2, params)

      {:noreply, assign(socket, form: form)}
    else
      {:error, error_message} ->
        {:noreply, socket |> put_flash(:error, error_message)}
    end
  end

  def handle_event(
        "direct-ownership",
        %{"share_information" => %{"direct_shareownership" => direct_share_ownership}},
        socket
      ) do
    max =
      socket.assigns.form.data.share_information &&
        socket.assigns.form.data.share_information.percentage

    with {:ok, direct_shares} <- parse_shares(direct_share_ownership) do
      indirect_ownership = max - direct_shares

      updated_info =
        socket.assigns.form.data.share_information
        |> Helpers.struct_to_map()
        |> Map.put(:direct_shareownership, trunc(indirect_ownership))

      update_shares =
        socket.assigns.form.data
        |> Helpers.struct_to_map()
        |> Map.put(:share_information, updated_info)

      form = update_form(socket, &BeneficialOwner.changeset/2, update_shares)

      {:noreply, assign(socket, form: form)}
    else
      {:error, error_message} ->
        {:noreply, socket |> put_flash(:error, error_message)}
    end
  end

  def handle_event(
        "add-share-ownership",
        params,
        socket
      ) do
    form =
      Brs.Forms.ShareInformation.update_indirect_shares(socket.assigns.form.data, params)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event(
        "add-voting-rights",
        params,
        socket
      ) do
    form =
      Brs.Forms.ShareInformation.update_voting_rights(socket.assigns.form.data, params)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.apply_changes()
      |> Ecto.Changeset.change()
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("cancel-shares", %{"category" => category}, socket) do
    share_info = socket.assigns.form_data["share_information"] || %{"total_shares" => 0}
    total_shares = share_info["total_shares"]

    form =
      case socket.assigns.form.data do
        %{share_information: %{shares: shares} = share_info} = form_data ->
          updated_shares = Enum.reject(shares, &(&1.name == category))
          shares_number = Enum.reduce(updated_shares, 0, &(&1.issued + &2))

          with {:ok, percentage} <- calculate_percentage(total_shares, shares_number) do
            updated_share_info = %{share_info | shares: updated_shares, percentage: percentage}
            %{form_data | share_information: updated_share_info} |> apply_changes()
          end

        form_data ->
          form_data |> apply_changes()
      end

    {:noreply, assign(socket, form: form)}
  end

  defp update_share_information(socket, params) do
    current_info = socket.assigns.form.data.share_information |> get_share_info()
    updated_info = Map.merge(current_info, params["share_information"] || %{})
    Map.put(params, "share_information", updated_info)
  end

  defp get_share_info(nil), do: %{}
  defp get_share_info(info), do: info |> Helpers.struct_to_map() |> Helpers.stringify_keys()

  defp update_form(socket, func, params) do
    socket.assigns.form.data |> func.(params) |> apply_changes()
  end

  defp apply_changes(form_data) do
    form_data
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.apply_changes()
    |> Ecto.Changeset.change()
    |> to_form()
  end

  defp parse_shares(shares) do
    case Integer.parse(shares) do
      {number, ""} when number > 0 ->
        {:ok, number}

      _ ->
        {:error, "Invalid number of shares. Please enter a positive integer."}
    end
  end

  defp calculate_percentage(total_shares, shares) do
    if shares > 0 do
      percentage = Float.round(shares / total_shares * 100, 2)
      {:ok, percentage}
    else
      {:ok, 0}
    end
  end
end
