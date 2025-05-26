defmodule BrsWeb.Forms.ProposedNamesComponent do
  alias Brs.Helpers
  alias Brs.Forms.PvtForm.ProposedName
  import Phoenix.HTML.Form
  use BrsWeb, :live_component

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    form = socket.assigns.form

    changeset =
      form.data
      |> ProposedName.changeset(form.params)

    if changeset.valid? do
      # Notify the parent component
      proposed_names =
        changeset
        |> Ecto.Changeset.apply_changes()
        |> Map.from_struct()
        |> Helpers.stringify_keys()

      send(self(), {:save_draft, %{"proposed_names" => proposed_names}})

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
    form_data = Map.get(assigns, :form_data) || %{}

    changeset =
      case form_data do
        %{"proposed_names" => params} ->
          ProposedName.changeset(%ProposedName{}, params)

        _ ->
          ProposedName.changeset(%ProposedName{})
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, to_form(changeset, as: "form"))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <h3>
        <div class="bg-[#d1ecf1] text-[#0c5460] border border-[#bee5eb] px-3 py-2 rounded">
          Enter your proposed names in order of priority.
        </div>
      </h3>
      <.form id="proposed-names-form" for={@form} phx-target={@myself} phx-change="validate">
        <div class="grid grid-cols-12 gap-5 pt-8 sm:gap-x-5 sm:gap-y-7">
          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Proposed Names<span aria-hidden="true" class="inline-block pl-1 text-red-500">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name={input_name(@form, :name)}
                value={input_value(@form, :name)}
                id="first-name"
                placeholder="Type your preferred name here..."
                autocomplete="given-name"
                class="block w-full px-3 py-2 text-sm text-gray-900 bg-white border border-gray-300 rounded-md placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
          </div>

          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Affiliated to an Existing Entity<span
                aria-hidden="true"
                class="inline-block pl-1 text-red-500"
              >*</span>
            </label>
            <div class="mt-1">
              <select
                id="affliated"
                name={input_name(@form, :affliated)}
                class="w-full py-2 pl-3 pr-8 text-base text-gray-500 bg-white border border-gray-300 rounded-md appearance-none focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option selected="">Choose...</option>
                <option value="YES">YES</option>
                <option value="NO">No</option>
              </select>
            </div>
          </div>
          <!-- separator -->
          <section class="col-span-12 mb-1 border-b border-gray-300"></section>
          <!-- separator -->
          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Proposed Names<span aria-hidden="true" class="inline-block pl-1 text-red-500">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name="first-name"
                id="first-name"
                placeholder="Type your preferred name here..."
                autocomplete="given-name"
                class="block w-full px-3 py-2 text-sm text-gray-900 bg-white border border-gray-300 rounded-md placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
          </div>

          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Affiliated to an Existing Entity<span
                aria-hidden="true"
                class="inline-block pl-1 text-red-500"
              >*</span>
            </label>
            <div class="mt-1">
              <select
                id="location"
                name="location"
                class="w-full py-2 pl-3 pr-8 text-base text-gray-500 bg-white border border-gray-300 rounded-md appearance-none focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option selected="">Choose...</option>
                <option value="YES">YES</option>
                <option value="NO">No</option>
              </select>
            </div>
          </div>
          <!-- separator -->
          <section class="col-span-12 mb-1 border-b border-gray-300"></section>
          <!-- separator -->
          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Proposed Names<span aria-hidden="true" class="inline-block pl-1 text-red-500">*</span>
            </label>
            <div class="mt-1">
              <input
                type="text"
                name="first-name"
                id="first-name"
                placeholder="Type your preferred name here..."
                autocomplete="given-name"
                class="block w-full px-3 py-2 text-sm text-gray-900 bg-white border border-gray-300 rounded-md placeholder:text-gray-500 focus:border-primary-500 focus:ring-1 focus:ring-primary-500"
              />
            </div>
          </div>

          <div class="col-span-12 md:col-span-6">
            <label for="first-name" class="block text-sm font-semibold text-gray-900">
              Affiliated to an Existing Entity<span
                aria-hidden="true"
                class="inline-block pl-1 text-red-500"
              >*</span>
            </label>
            <div class="mt-1">
              <select
                id="location"
                name="location"
                class="w-full py-2 pl-3 pr-8 text-base text-gray-500 bg-white border border-gray-300 rounded-md appearance-none focus:border focus:border-primary-500 focus:ring-1 focus:ring-primary-500 sm:text-sm"
              >
                <option selected="">Choose...</option>
                <option value="YES">YES</option>
                <option value="NO">No</option>
              </select>
            </div>
          </div>
          <!-- separator -->
          <section class="col-span-12 mb-1 border-b border-gray-300"></section>
          <!-- separator -->
          <div class="col-span-12 text-right">
            <button class="inline-block px-2 text-sm font-medium text-green-600 whitespace-nowrap hover:underline">
              Add Proposed Name
            </button>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event("validate", %{"form" => form_params} = _params, socket) do
    form =
      socket.assigns.form.source.data
      |> ProposedName.changeset(form_params)
      |> to_form(action: :validate, as: "form")

    {:noreply, assign(socket, form: form)}
  end
end
