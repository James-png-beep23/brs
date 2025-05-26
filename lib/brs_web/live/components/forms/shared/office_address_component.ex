defmodule BrsWeb.Forms.OfficeAddressComponent do
  alias Brs.Forms.PvtForm.RegisteredOfficeAddress
  use BrsWeb, :live_component
  import Phoenix.HTML.Form
  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    form = socket.assigns.form

    changeset =
      form.source.data
      |> RegisteredOfficeAddress.changeset(form.params)

    if changeset.valid? do
      send(self(), {:save_draft, %{"registered_office_address" => form.params}})

      {:ok, assign(socket, assigns)}
    else
      {:ok,
       assign(socket, assigns)
       |> assign(form: to_form(changeset, action: :validate, as: "form"))}
    end
  end

  def update(assigns, socket) do
    form_data = Map.get(assigns, :form_data)

    changeset =
      case form_data do
        %{"registered_office_address" => params} ->
          RegisteredOfficeAddress.changeset(%RegisteredOfficeAddress{}, params)

        _ ->
          RegisteredOfficeAddress.changeset(%RegisteredOfficeAddress{})
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <h4 class="text-base md:text-lg font-semibold text-gray-900 mb-1">
        Registered Addresses
      </h4>
      <h5 class="text-sm md:text-base font-bold text-gray-900 flex items-center justify-between">
        Primary Address
      </h5>
      <.form id="office-address-form" for={@form} phx-target={@myself} phx-change="validate">
        <div class="grid grid-col-1 sm:grid-col-2 lg:grid-cols-3 gap-4 mt-4">
          <!-- County Field -->
          <div>
            <label for="location" class="block text-sm font-semibold text-gray-900">
              County<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <select
                id="county"
                name={input_name(@form, :county)}
                class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option value="">Choose...</option>
                <option value="1" selected={input_value(@form, :county) == "1"}>BARINGO</option>
                <option value="2" selected={input_value(@form, :county) == "2"}>BOMET</option>
                <option value="3">BUNGOMA</option>
                <option value="4">Busia</option>
                <option value="5">Elgeyo/Marakwet</option>
                <option value="6">EMBU</option>
                <option value="7">Garissa</option>
                <option value="8">Homa Bay</option>
                <option value="9">ISIOLO</option>
                <option value="10">Kajiado</option>
                <option value="11">Kakamega</option>
                <option value="12">Kericho</option>
                <option value="13">Kiambu</option>
                <option value="14">Kilifi</option>
                <option value="15">Kirinyaga</option>
                <option value="16">KISII</option>
                <option value="17">Kisumu</option>
                <option value="18">Kitui</option>
                <option value="19">Kwale</option>
                <option value="20">Laikipia</option>
                <option value="21">Lamu</option>
                <option value="22">Machakos</option>
                <option value="23">Makueni</option>
                <option value="24">Mandera</option>
                <option value="25">Marsabit</option>
                <option value="26">Meru</option>
                <option value="27">Migori</option>
                <option value="28">Mombasa</option>
                <option value="29">Muranga</option>
                <option value="30">Nairobi</option>
                <option value="31">Nakuru</option>
                <option value="32">Nandi</option>
                <option value="33">Narok</option>
                <option value="34">Nyamira</option>
                <option value="35">Nyandarua</option>
                <option value="36">Nyeri</option>
                <option value="37">Samburu</option>
                <option value="38">Siaya</option>
                <option value="39">Taita Taveta</option>
                <option value="40">Tana River</option>
                <option value="41">Tharaka Nithi</option>
                <option value="42">Trans Nzoia</option>
                <option value="43">Turkana</option>
                <option value="44">Uasin Gishu</option>
                <option value="45">Vihiga</option>
                <option value="46">WAJIR</option>
                <option value="47">WEST POKOT</option>
              </select>
              <div class="hidden text-red-500 text-sm mt-1">Error message</div>
              <%= error_tag(@form, :county) %>
            </div>
          </div>
          <!-- District Field -->
          <div>
            <label for="district" class="block text-sm font-semibold text-gray-900">
              District<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <select
                id="district"
                name={input_name(@form, :district)}
                class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option value="">Choose...</option>
                <option value="93" selected={input_value(@form, :district) == "93"}>
                  Westlands District
                </option>
              </select>
              <div class="hidden text-red-500 text-sm mt-1">Error message</div>
              <%= error_tag(@form, :district) %>
            </div>
          </div>
          <!-- Locality Field -->
          <div>
            <label for="locality" class="block text-sm font-semibold text-gray-900">
              Locality<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <select
                id="locality"
                name={input_name(@form, :locality)}
                class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option value="">Choose...</option>
                <option value="579" selected={input_value(@form, :locality) == "579"}>
                  Westlands
                </option>
              </select>
              <div class="hidden text-red-500 text-sm mt-1">Error message</div>
            </div>
          </div>
          <!-- Building/Plot No./Estate and House No. -->
          <div>
            <label for="building" class="block text-sm font-semibold text-gray-900">
              Name of building/Plot No./Estate and House No.<span
                aria-hidden="true"
                class="text-red-500 inline-block pl-1"
              >*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :building)}
                value={input_value(@form, :building)}
                id="building"
                placeholder=""
                autocomplete="building"
                aria-label="Name of building/Plot No./Estate and House No."
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :building) %>
            <div id="building_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Street/Road -->
          <div>
            <label for="building" class="block text-sm font-semibold text-gray-900">
              Street/Road<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :street)}
                value={input_value(@form, :street)}
                id="street"
                placeholder=""
                autocomplete="Street/Road"
                aria-label="Name of building/Plot No./Estate and House No."
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :street) %>
            <div id="building_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Floor -->
          <div>
            <label for="floor" class="block text-sm font-semibold text-gray-900">
              Floor<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :floor)}
                value={input_value(@form, :floor)}
                id="floor"
                placeholder=""
                autocomplete="Floor"
                aria-label="Name of building/Plot No./Estate and House No."
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :floor) %>
            <div id="floor_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Room/Door No -->
          <div>
            <label for="room" class="block text-sm font-semibold text-gray-900">
              Floor<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :room)}
                value={input_value(@form, :room)}
                id="room"
                placeholder=""
                autocomplete="room"
                aria-label="Room/Door No"
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :room) %>
            <div id="room_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Postal Address -->
          <div>
            <label for="postal_address" class="block text-sm font-semibold text-gray-900">
              Postal Address<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :postal_address)}
                value={input_value(@form, :postal_address)}
                id="postal_address"
                placeholder=""
                autocomplete="postal_address"
                aria-label="Postal Address"
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :postal_address) %>
            <div id="postal_address_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Postal Address -->
          <div>
            <label for="postal_address" class="block text-sm font-semibold text-gray-900">
              Postal Address<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :postal_address)}
                value={input_value(@form, :postal_address)}
                id="postal_address"
                placeholder=""
                autocomplete="postal_address"
                aria-label="Postal Address"
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :postal_address) %>
            <div id="postal_address_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Postal Code -->
          <div>
            <label for="postal_code" class="block text-sm font-semibold text-gray-900">
              Postal Code<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <select
                id="postal_code"
                name={input_name(@form, :postal_code)}
                class="w-full appearance-none rounded-md bg-white py-2 pl-3 pr-8 border border-gray-300 text-base text-gray-500 focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option value="" disabled selected>Choose...</option>
                <option value="00100" selected={input_value(@form, :postal_code) == "00100"}>
                  00100 - G.P.O NAIROBI
                </option>
              </select>
              <%= error_tag(@form, :postal_code) %>
              <div id="postal_code_error" class="hidden text-red-500 text-sm mt-1"></div>
            </div>
          </div>
          <!-- Mobile Number -->
          <div>
            <label for="mobile_number" class="block text-sm font-semibold text-gray-900">
              Mobile Number<span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :mobile_number)}
                value={input_value(@form, :mobile_number)}
                id="mobile_number"
                placeholder=""
                autocomplete="mobile_number"
                aria-label="Mobile Number"
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :mobile_number) %>
            <div id="mobile_number_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
          <!-- Company Email Address  -->
          <div>
            <label for="email" class="block text-sm font-semibold text-gray-900">
              Company Email Address
              <span aria-hidden="true" class="text-red-500 inline-block pl-1">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :email)}
                value={input_value(@form, :email)}
                id="email"
                placeholder=""
                autocomplete="email"
                aria-label="Company Email Address"
                class="block w-full rounded-md bg-white px-3 py-2 text-sm text-gray-900 border border-gray-300 placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
            <%= error_tag(@form, :email) %>
            <div id="email_error" class="hidden text-red-500 text-sm mt-1"></div>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event(
        "validate",
        %{"form" => form_params} = _params,
        socket
      ) do
    form =
      socket.assigns.form.source.data
      |> RegisteredOfficeAddress.changeset(form_params)
      |> Map.put(:action, :validate)
      |> to_form(as: "form")

    {:noreply,
     socket
     |> assign(:form, form)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: "form"))
  end
end
