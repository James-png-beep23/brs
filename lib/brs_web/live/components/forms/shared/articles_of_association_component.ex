defmodule BrsWeb.Forms.ArticlesOfAssociationComponent do
  alias Brs.Forms.PvtForm.ArticlesOfAssociation
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    form = socket.assigns.form

    changeset =
      form.source.data
      |> ArticlesOfAssociation.changeset(form.params)

    if changeset.valid? do
      send(self(), {:save_draft, %{"articles_of_association" => form.params}})

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
        %{"articles_of_association" => params} ->
          ArticlesOfAssociation.changeset(%ArticlesOfAssociation{}, params)

        _ ->
          ArticlesOfAssociation.changeset(%ArticlesOfAssociation{})
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset, as: "form"))
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <.form
        id="pvt-registration-form"
        for={@form}
        phx-target={@myself}
        phx-change="validate_articles_of_association"
      >
        <div class="mb-8">
          <h3 class="text-sm font-medium text-gray-400 mb-2 uppercase">ARTICLES OF ASSOCIATION</h3>
          <div><hr /></div>
          <div class="mt-6">
            <label class="block mb-2 text-sm font-medium">
              Articles of Association adopted <span class="text-red-500">*</span>
            </label>
            <%= error_tag(@form, :memorandum) %>
            <p class="mb-3 text-sm text-gray-400">(Select the option that applies)</p>

            <div class="space-y-4">
              <div class="flex items-center">
                <input
                  type="radio"
                  value="standard"
                  name={input_name(@form, :memorandum)}
                  class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                  checked={input_value(@form, :memorandum) == "standard"}
                />
                <label for="option1" class="ml-3 text-sm text-gray-700">
                  The company will adopt the model articles of association applicable to the type of company selected.
                </label>
              </div>
              <div class="flex items-center">
                <input
                  type="radio"
                  value="partial"
                  name={input_name(@form, :memorandum)}
                  class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                  checked={input_value(@form, :memorandum) == "partial"}
                />
                <label for="option2" class="ml-3 text-sm text-gray-700">
                  The company will adopt some of those model articles and has prepared its own articles of association to supplement or modify those model articles or
                </label>
              </div>
              <div class="flex items-center">
                <input
                  type="radio"
                  value="own"
                  name={input_name(@form, :memorandum)}
                  class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                  checked={input_value(@form, :memorandum) == "own"}
                />
                <label for="option3" class="ml-3 text-sm text-gray-700">
                  The company has prepared its own articles of association
                </label>
              </div>
            </div>
          </div>
          <div class="mt-6">
            <div
              :if={input_value(@form, :memorandum) == "standard"}
              class="flex justify-center inline-block w-full p-4 bg-blue-100 rounded text-md"
            >
              <a
                href="https://brs.go.ke/download/model-articles-private-companies-limited-by-shares/"
                target="_blank"
                class="text-blue-600"
              >
                Click here
              </a>
              <span class="ml-1">
                to view the articles of association
              </span>
            </div>
            <div
              :if={input_value(@form, :memorandum) in ["partial", "own"]}
              class="flex justify-center inline-block w-full p-4 bg-blue-100 rounded text-md"
            >
              <p>
                If the company has prepared its own articles or articles to supplement or modify the model articles, those articles should be contained in a single document, printed, divided into paragraphs numbered consecutively, dated, and signed by each subscriber to the articles. A subscribers' signature should be attested by a witness whose name, occupation, and postal address are required to be written or printed below the subscriber’s signature.
              </p>
            </div>
          </div>
        </div>

        <div :if={input_value(@form, :memorandum) == "partial"} class="mb-8">
          <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
            Attach modified articles of association (Max 2MB) <span class="text-red-600">*</span>
          </label>
          <input
            class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
            type="file"
            name={input_name(@form, :attached_articles)}
            id="attached_articles"
          />
        </div>

        <div :if={input_value(@form, :memorandum) == "own"} class="mb-8">
          <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
            Attach your own articles of association (Max 2MB) <span class="text-red-600">*</span>
          </label>
          <input
            class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
            type="file"
            name={input_name(@form, :own_articles_of_association)}
            id="attached_articles"
          />
        </div>

        <div class="mb-8">
          <label class="block mb-2 text-sm font-medium">
            Objects (if any) for which the company is established <span class="text-red-500">*</span>
          </label>

          <div class="space-y-4">
            <div class="flex items-center">
              <input
                type="radio"
                value="N"
                name={input_name(@form, :objects_choice)}
                class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                checked={input_value(@form, :objects_choice) == "N"}
              />
              <label for="non-regulated" class="ml-3 text-sm text-gray-700">Non Regulated</label>
            </div>
            <div class="flex items-center">
              <input
                type="radio"
                value="Y"
                name={input_name(@form, :objects_choice)}
                checked={input_value(@form, :objects_choice) == "Y"}
                class="w-4 h-4 text-blue-600 border-gray-300 focus:ring-blue-500"
              />
              <label for="regulated" class="ml-3 text-sm text-gray-700">Regulated</label>
            </div>
          </div>
        </div>

        <div :if={input_value(@form, :objects_choice) == "N"} class="mb-8">
          <label for="primary-objects" class="block mb-2 text-sm font-medium">
            Primary Objects of the Company <span class="text-red-500">*</span>
          </label>
          <input
            id="primary-objects"
            type="text"
            name={input_name(@form, :bs_nature_select)}
            class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
          />
        </div>

        <div :if={input_value(@form, :objects_choice) == "Y"}>
          <div class="mb-8">
            <label class="block mb-1 text-sm font-medium" for="primary-activity-regulated">
              Primary Activity Regulated <span class="text-red-600">*</span>
            </label>
            <p class="mt-1 text-sm text-gray-500">
              Select one
            </p>
            <select
              id="primary-activity-regulated"
              name={input_name(@form, :objects_regulated)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="" disabled selected>Choose...</option>
              <option value="university">
                University
              </option>
              <option value="finance">
                Banks, Microfinance, Forex Bureaus
              </option>
              <option value="gaming">
                Gaming Room, Casinos
              </option>
              <option value="sez">
                Special Economic Zone
              </option>
              <option value="epz">
                Export Processing Zone
              </option>
              <option value="other">
                Other
              </option>
            </select>
          </div>

          <div :if={input_value(@form, :objects_regulated) == "other"} class="mb-8">
            <label for="other-objects" class="block mb-2 text-sm font-medium">
              Other objects for which company is established <span class="text-red-500">*</span>
            </label>
            <input
              id="other-objects"
              type="text"
              name={input_name(@form, :other_objects)}
              class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          <div :if={input_value(@form, :objects_regulated) == "university"} class="mb-8">
            <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
              Attach Commission of University Education No Objection Letter (Max 2MB)
              <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :commision_of_university)}
              id="commision_of_university"
            />
          </div>

          <div :if={input_value(@form, :objects_regulated) == "finance"} class="mb-8">
            <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
              Attach name approval letter from Central Bank of Kenya (Max 2MB)
              <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :name_approval_letter)}
              id="name_approval_letter"
            />
          </div>

          <div :if={input_value(@form, :objects_regulated) == "gaming"} class="mb-8">
            <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
              Attach no objection letter from Betting Control And Licensing Board (Max 2MB)
              <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :documents)}
              id="documents"
            />
          </div>

          <div :if={input_value(@form, :objects_regulated) == "sez"} class="mb-8">
            <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
              Attach no objection letter from Special Economic Zone Authority (Max 2MB)
              <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :special_economic_zone)}
              id="special_economic_zone"
            />
          </div>

          <div :if={input_value(@form, :objects_regulated) == "epz"} class="mb-8">
            <label class="block mb-2 font-medium text-gray-700" for="attached_articles">
              Attach no objection letter from Export Processing Zone Authority (Max 2MB)
              <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :export_processing_zone)}
              id="export_processing_zone"
            />
          </div>
        </div>

        <div class="mb-8">
          <h3 class="text-sm font-medium text-gray-400 mb-3 uppercase">PRIMARY BUSINESS ACTIVITY</h3>
          <div><hr /></div>

          <div class="grid grid-cols-2 gap-6 mt-3">
            <div>
              <label for="sector" class="block mb-2 text-sm font-medium">
                Sector <span class="text-red-500">*</span>
              </label>
              <select
                id="sector"
                name={input_name(@form, :kra_business_activity_sector_select)}
                class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="19">S - Other Service Activities</option>
              </select>
            </div>

            <div>
              <label for="division" class="block mb-2 text-sm font-medium">
                Division <span class="text-red-500">*</span>
              </label>
              <select
                id="division"
                name={input_name(@form, :kra_business_activity_division_select)}
                class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="768">96 - Other service activities</option>
              </select>
            </div>

            <div>
              <label for="group" class="block mb-2 text-sm font-medium">
                Group <span class="text-red-500">*</span>
              </label>
              <select
                id="group"
                name={input_name(@form, :kra_business_activity_group_select)}
                class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="669">960 - Other service activities</option>
              </select>
            </div>

            <div>
              <label for="class" class="block mb-2 text-sm font-medium">
                Class <span class="text-red-500">*</span>
              </label>
              <select
                id="class"
                name={input_name(@form, :kra_business_activity_class_select)}
                class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="673">9609 - Other service activities n.e.c.</option>
              </select>
            </div>
          </div>
        </div>
        <div class="flex flex-wrap ">
          <div class="mb-8 w-1/2 pe-2">
            <label for="target-start-date" class="block mb-2 text-sm font-medium">
              Target Business Start date <span class="text-red-500">*</span>
            </label>
            <input
              id="target-start-date"
              type="date"
              name={input_name(@form, :registration_start_date)}
              class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
            />
          </div>

          <div class="mb-8  w-1/2 ps-4">
            <label for="acc-period-month" class="block mb-2 text-sm font-medium">
              Accounting Period End Month <span class="text-red-500">*</span>
            </label>
            <input
              id="acc-period-month"
              type="month"
              name={input_name(@form, :acc_period_end_month)}
              class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
        </div>

        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="employees">
              Number of Employees at Target Start Date <span class="text-red-600">*</span>
            </label>
            <input
              type="number"
              id="employees"
              name={input_name(@form, :no_of_employees)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <p class="mt-1 text-sm text-gray-500">
              NOTE: Include ONLY the number of employees expected to earn more than KShs. 13,486 monthly and 0 if none.
            </p>
          </div>
          <!-- Estimated Annual Turnover -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="turnover">
              Estimated annual turnover (KES) <span class="text-red-600">*</span>
            </label>
            <input
              type="number"
              id="turnover"
              name={input_name(@form, :estimated_annual_turnover)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <p class="mt-1 text-sm text-gray-500">
              NOTE: You will automatically be registered for Value Added Tax (VAT) if your annual turnover is more than
              KShs. 5,000,000.
            </p>
          </div>
        </div>
        <!-- Row 2 -->
        <div class="grid grid-cols-1 gap-6 mt-6 sm:grid-cols-2">
          <!-- Subsidiary or Branch -->
          <div>
            <label class="block mb-2 text-sm font-medium text-gray-700">
              Is the Company you are registering a Subsidiary Company or a branch?
              <span class="text-red-600">*</span>
            </label>
            <div class="flex items-center space-x-4">
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="Y"
                  name={input_name(@form, :is_subsidiary)}
                  checked={input_value(@form, :is_subsidiary) == "Y"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">Yes</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="N"
                  name={input_name(@form, :is_subsidiary)}
                  checked={input_value(@form, :is_subsidiary) == "N"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">No</span>
              </label>
            </div>
          </div>
          <!-- Holding Company Resident -->
          <div :if={input_value(@form, :is_subsidiary) == "Y"}>
            <label class="block mb-2 text-sm font-medium text-gray-700">
              Is the Principal Holding company Resident in Kenya? <span class="text-red-600">*</span>
            </label>
            <div class="flex items-center space-x-4">
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="Y"
                  name={input_name(@form, :is_subsidiary_resident)}
                  checked={input_value(@form, :is_subsidiary_resident) == "Y"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">Yes</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="N"
                  name={input_name(@form, :is_subsidiary_resident)}
                  checked={input_value(@form, :is_subsidiary_resident) == "N"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">No</span>
              </label>
            </div>
          </div>
        </div>

        <div :if={input_value(@form, :is_subsidiary_resident) == "Y"} class="mb-8">
          <label for="holding-company-pin" class="block mb-2 text-sm font-medium">
            Holding Company Pin <span class="text-red-500">*</span>
          </label>
          <input
            id="holding-company-pin"
            type="text"
            name={input_name(@form, :subsidiary_kra_pin)}
            class="block w-full text-sm border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
          />
        </div>

        <div
          :if={input_value(@form, :is_subsidiary_resident) == "N"}
          class="grid grid-cols-1 gap-6 mt-6 sm:grid-cols-2"
        >
          <!-- Holding Company Name -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="holding-name">
              Holding Company Name <span class="text-red-600">*</span>
            </label>
            <input
              type="text"
              id="holding-name"
              name={input_name(@form, :subsidiary_name)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <!-- Holding Company Country -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="holding-country">
              Holding Company Country <span class="text-red-600">*</span>
            </label>
            <select
              id="holding-country"
              name={input_name(@form, :subsidiary_country)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="" disabled selected>Choose...</option>
              <option value="kenya">Kenya</option>
              <option value="usa">USA</option>
              <option value="uk">UK</option>
              <option value="other">Other</option>
            </select>
          </div>
        </div>
        <!-- Row 4 -->
        <div class="grid grid-cols-1 gap-6 mt-6 sm:grid-cols-2">
          <!-- Amalgamation or Acquisition -->
          <div>
            <label class="block mb-2 text-sm font-medium text-gray-700">
              Was your business formed as a result of amalgamation or acquisition?
              <span class="text-red-600">*</span>
            </label>
            <div class="flex items-center space-x-4">
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="Y"
                  name={input_name(@form, :is_amalgamated)}
                  checked={input_value(@form, :is_amalgamated) == "Y"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">Yes</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="N"
                  name={input_name(@form, :is_amalgamated)}
                  checked={input_value(@form, :is_amalgamated) == "N"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">No</span>
              </label>
            </div>
          </div>
          <!-- Details of Bond -->
          <div :if={input_value(@form, :is_amalgamated) == "Y"}>
            <label class="block mb-2 text-sm font-medium text-gray-700">
              Details of Bond <span class="text-red-600">*</span>
            </label>
            <div class="flex items-center space-x-4">
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="amalgamation"
                  name={input_name(@form, :bond)}
                  checked={input_value(@form, :bond) == "amalgamation"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">Amalgamation</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="radio"
                  value="acquisition"
                  name={input_name(@form, :bond)}
                  checked={input_value(@form, :bond) == "acquisition"}
                  class="text-blue-500 focus:ring-blue-500"
                />
                <span class="ml-2">Acquisition</span>
              </label>
            </div>
          </div>
        </div>

        <div :if={input_value(@form, :is_amalgamated) == "Y"} class="grid grid-cols-1 gap-6 mt-6">
          <!-- Holding Company Pin -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="pin">
              Holding Company Pin <span class="text-red-600">*</span>
            </label>
            <input
              type="text"
              id="pin"
              name={input_name(@form, :registration_company_pin)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <!-- Holding Company's Name -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="company-name">
              Holding Company's name <span class="text-red-600">*</span>
            </label>
            <input
              type="text"
              id="company-name"
              name={input_name(@form, :registration_tax_payer_name)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <!-- Holding Company's Email -->
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="email">
              Holding Company's Email on iTax <span class="text-red-600">*</span>
            </label>
            <input
              type="email"
              id="email"
              name={input_name(@form, :subsidiary_kra_email)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="amalgamation-date">
              Amalgamation Date <span class="text-red-600">*</span>
            </label>
            <input
              type="date"
              id="amalgamation-date"
              name={input_name(@form, :amalgamation_date)}
              class="w-full text-sm text-gray-900 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700" for="letter-of-competition">
              Letter from Competition Authority of Kenya <span class="text-red-600">*</span>
            </label>
            <input
              class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-sm file:bg-[#1E293B] file:text-gray-200"
              type="file"
              name={input_name(@form, :competition_letter)}
              id="letter-of-competition"
            />
          </div>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event("validate_articles_of_association", %{"form" => form_params} = _params, socket) do
    form =
      socket.assigns.form.source.data
      |> ArticlesOfAssociation.changeset(form_params)
      |> to_form(action: :validate, as: "form")

    {:noreply, assign(socket, form: form)}
  end
end
