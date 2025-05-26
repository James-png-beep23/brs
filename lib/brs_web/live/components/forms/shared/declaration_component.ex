defmodule BrsWeb.Forms.DeclarationComponent do
  use BrsWeb, :live_component

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    case assigns[:submit] do
      true ->
        send(self(), {"make-application", %{declaration: %{}}})

      _ ->
        send(self(), {:save_draft, %{declaration: %{}}})
    end

    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full px-4 pb-0">
      <h3 class="mb-2 text-lg font-bold">Declaration</h3>
      <div class="flex items-center mb-4">
        <input
          id="default-checkbox"
          type="checkbox"
          value=""
          class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2"
        />
        <label for="default-checkbox" class="text-sm font-medium ms-2">
          I hereby confirm that I have provided all the information as required by the Registrar in regard to this application
        </label>
      </div>
    </div>
    """
  end
end
