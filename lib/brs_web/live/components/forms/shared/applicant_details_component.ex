defmodule BrsWeb.Forms.ApplicantDetailsComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  alias Brs.Forms.PvtForm.ApplicantDetails

  @impl true
  def update(%{form_action: :submit_form}, socket) do
    form = socket.assigns.form

    changeset =
      form.source.data
      |> ApplicantDetails.changeset(form.params)

    if changeset.valid? do
      send(self(), {:save_draft, %{"applicant_details" => form.params}})

      {:ok, socket}
    else
      {:ok, assign(socket, form: to_form(changeset, action: :validate, as: "form"))}
    end
  end

  def update(assigns, socket) do
    form_data = Map.get(assigns, :form_data)

    changeset =
      case form_data do
        %{"applicant_details" => params} ->
          ApplicantDetails.changeset(%ApplicantDetails{}, params)

        _ ->
          ApplicantDetails.changeset(%ApplicantDetails{})
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate_applicant_details", %{"form" => form_params} = _params, socket) do
    form =
      socket.assigns.form.source.data
      |> ApplicantDetails.changeset(form_params)
      |> to_form(action: :validate, as: "form")

    {:noreply,
     socket
     |> assign(:form, form)}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: "form"))
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <.form
        id="applicant-details-form"
        for={@form}
        phx-target={@myself}
        phx-change="validate_applicant_details"
      >
        <h2 class="mb-6 text-lg font-semibold text-gray-600">APPLICANT DETAILS</h2>
        <div class="grid grid-cols-1 gap-6 sm:grid-cols-3">
          <!-- First Name -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">First Name</label>
            <p class="text-base font-semibold text-black">VINCENT</p>
            <input
              type="hidden"
              name={input_name(@form, :first_name)}
              value={input_value(@form, :first_name)}
            />
            <%= error_tag(@form, :first_name) %>
          </div>
          <!-- Middle Name -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">Middle Name</label>
            <p class="text-base font-semibold text-black">NJERU</p>
            <input
              type="hidden"
              name={input_name(@form, :middle_name)}
              value={input_value(@form, :middle_name)}
            />
            <%= error_tag(@form, :middle_name) %>
          </div>
          <!-- Last Name -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">Last Name</label>
            <p class="text-base font-semibold text-black">MBUGUA</p>
            <input
              type="hidden"
              name={input_name(@form, :last_name)}
              value={input_value(@form, :last_name)}
            />
            <%= error_tag(@form, :last_name) %>
          </div>
        </div>

        <div class="grid grid-cols-1 gap-6 mt-6 sm:grid-cols-2">
          <!-- Capacity -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              Capacity <span class="text-red-500">*</span>
            </label>
            <select
              name={input_name(@form, :registration_applicant_capacity)}
              class="w-full text-sm text-gray-700 border-gray-300 rounded-lg"
            >
              <option disabled selected>Choose...</option>
              <option
                value="secretary"
                selected={input_value(@form, :registration_applicant_capacity) == "secretary"}
              >
                Secretary
              </option>
              <option
                value="director"
                selected={input_value(@form, :registration_applicant_capacity) == "director"}
              >
                Director
              </option>
              <option
                value="director_shareholder"
                selected={
                  input_value(@form, :registration_applicant_capacity) == "director_shareholder"
                }
              >
                Director Shareholder
              </option>
              <option
                value="advocate"
                selected={input_value(@form, :registration_applicant_capacity) == "advocate"}
              >
                Advocate
              </option>
            </select>
            <%= error_tag(@form, :registration_applicant_capacity) %>
          </div>
          <!-- LSK Number -->
          <div :if={input_value(@form, :registration_applicant_capacity) == "advocate"}>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              LSK Number <span class="text-red-500">*</span>
            </label>
            <input
              type="text"
              name={input_name(@form, :lsk_number)}
              value={input_value(@form, :lsk_number)}
              class="w-full px-3 py-2 text-sm text-gray-700 border border-gray-300 rounded-lg"
            />
            <%= error_tag(@form, :lsk_number) %>
          </div>
          <!-- ICS Number -->
          <div :if={input_value(@form, :registration_applicant_capacity) == "secretary"}>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              ICS Number <span class="text-red-500">*</span>
            </label>
            <input
              type="text"
              name={input_name(@form, :ics_number)}
              value={input_value(@form, :ics_number)}
              class="w-full px-3 py-2 text-sm text-gray-700 border border-gray-300 rounded-lg"
            />
            <%= error_tag(@form, :ics_number) %>
          </div>
          <!-- Practicing Number -->
          <div :if={input_value(@form, :registration_applicant_capacity) == "advocate"}>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              Practicing Number
            </label>
            <input
              type="text"
              name={input_name(@form, :adv_number)}
              value={input_value(@form, :adv_number)}
              class="w-full px-3 py-2 text-sm text-gray-700 border border-gray-300 rounded-lg"
            />
            <%= error_tag(@form, :adv_number) %>
          </div>
        </div>

        <div class="grid grid-cols-1 gap-6 mt-6 sm:grid-cols-2">
          <!-- Address -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              Address <span class="text-red-500">*</span>
            </label>
            <input
              type="text"
              name={input_name(@form, :registration_applicant_address)}
              value={input_value(@form, :registration_applicant_address)}
              class="w-full px-3 py-2 text-sm text-gray-700 border border-gray-300 rounded-lg"
            />
            <%= error_tag(@form, :registration_applicant_address) %>
          </div>
          <!-- Postal Code -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">
              Postal Code <span class="text-red-500">*</span>
            </label>
            <select
              name={input_name(@form, :registration_applicant_postal_code)}
              class="w-full text-sm text-gray-700 border-gray-300 rounded-lg"
            >
              <option disabled selected>Choose...</option>
              <option
                value="00100"
                selected={input_value(@form, :registration_applicant_postal_code) == "00100"}
              >
                00100 - G.P.O NAIROBI
              </option>
            </select>
            <%= error_tag(@form, :registration_applicant_postal_code) %>
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
