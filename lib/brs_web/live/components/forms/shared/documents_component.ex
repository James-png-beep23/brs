defmodule BrsWeb.Forms.DocumentsComponent do
  use BrsWeb, :live_component

  @impl true
  def update(%{form_action: :submit_form} = assigns, socket) do
    case assigns[:submit] do
      true ->
        send(self(), {"make-application", %{documents: %{}}})

      _ ->
        send(self(), {:save_draft, %{documents: %{}}})
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
      <h4 class="mb-1 text-base font-semibold text-gray-900 md:text-lg">Application Documents</h4>
      <div class="flex flex-wrap gap-4">
        <div class="w-full">
          <div id="sp_149" name="panel4">
            <div class="w-full">
              <h4 class="hidden mb-2 text-lg font-semibold">
                <span class="block">Application Documents</span>
              </h4>
              <div class="mb-2 text-sm text-gray-500"></div>
              <div
                role="alert"
                aria-live="polite"
                id="sp_149_errors"
                class="hidden alert alert-danger"
              >
              </div>
              <div id="sp_149_content">
                <!-- BOF-1 Form -->
                <div class="flex flex-wrap gap-4">
                  <div class="w-1/2">
                    <div id="sq_539" name="question4" class="pr-5">
                      <div class="mb-0">
                        <div
                          role="alert"
                          aria-live="polite"
                          id="sq_539_errors"
                          class="hidden alert alert-danger"
                        >
                        </div>
                        <div class="text-sm">
                          <a
                            href="/applications/4664153/downloads/bof_1"
                            target="_blank"
                            class="text-blue-600 hover:underline"
                          >
                            CLICK HERE TO DOWNLOAD BOF-1 <br />SIGN, SCAN AND UPLOAD BELOW
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="w-1/2">
                    <div id="sq_540" aria-labelledby="sq_540_ariaTitle" name="bof1">
                      <h5
                        aria-label="BOF-1 Form"
                        id="sq_540_ariaTitle"
                        class="block text-sm font-semibold text-gray-900"
                      >
                        <span class="text-red-500">*</span> BOF-1 Form
                      </h5>
                      <div
                        role="alert"
                        aria-live="polite"
                        id="sq_540_errors"
                        class="hidden alert alert-danger"
                      >
                      </div>
                      <div class="mt-2">
                        <input
                          type="file"
                          id="sq_540i"
                          aria-required="true"
                          aria-label="BOF-1 Form"
                          class="w-full p-2 border rounded form-input"
                          accept=".pdf"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <!-- CR-1 Form -->
                <div class="flex flex-wrap gap-4 mt-6">
                  <div class="w-1/2">
                    <div id="sq_541" name="question5" class="pr-5">
                      <div class="mb-0">
                        <div
                          role="alert"
                          aria-live="polite"
                          id="sq_541_errors"
                          class="hidden alert alert-danger"
                        >
                        </div>
                        <div class="text-sm">
                          <a
                            href="/applications/4664153/downloads/cr_1"
                            target="_blank"
                            class="text-blue-600 hover:underline"
                          >
                            CLICK HERE TO DOWNLOAD CR-1 <br />SIGN, SCAN AND UPLOAD BELOW
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="w-1/2">
                    <div id="sq_542" aria-labelledby="sq_542_ariaTitle" name="cr1">
                      <h5
                        aria-label="CR-1 Form"
                        id="sq_542_ariaTitle"
                        class="block text-sm font-semibold text-gray-900"
                      >
                        <span class="text-red-500">*</span> CR-1 Form
                      </h5>
                      <div
                        role="alert"
                        aria-live="polite"
                        id="sq_542_errors"
                        class="hidden alert alert-danger"
                      >
                      </div>
                      <div class="mt-2">
                        <input
                          type="file"
                          id="sq_542i"
                          aria-required="true"
                          aria-label="CR-1 Form"
                          class="w-full p-2 border rounded form-input"
                          accept=".pdf"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <!-- CR-2 Form -->
                <div class="flex flex-wrap gap-4 mt-6">
                  <div class="w-1/2">
                    <div id="sq_543" name="question6" class="pr-5">
                      <div class="mb-0">
                        <div
                          role="alert"
                          aria-live="polite"
                          id="sq_543_errors"
                          class="hidden alert alert-danger"
                        >
                        </div>
                        <div class="text-sm">
                          <a
                            href="/applications/4664153/downloads/cr_2"
                            target="_blank"
                            class="text-blue-600 hover:underline"
                          >
                            CLICK HERE TO DOWNLOAD CR-2 <br />SIGN, SCAN AND UPLOAD BELOW
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="w-1/2">
                    <div id="sq_544" aria-labelledby="sq_544_ariaTitle" name="cr2">
                      <h5
                        aria-label="CR-2 Form"
                        id="sq_544_ariaTitle"
                        class="block text-sm font-semibold text-gray-900"
                      >
                        <span class="text-red-500">*</span> CR-2 Form
                      </h5>
                      <div
                        role="alert"
                        aria-live="polite"
                        id="sq_544_errors"
                        class="hidden alert alert-danger"
                      >
                      </div>
                      <div class="mt-2">
                        <input
                          type="file"
                          id="sq_544i"
                          aria-required="true"
                          aria-label="CR-2 Form"
                          class="w-full p-2 border rounded form-input"
                          accept=".pdf"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <!-- CR-8 Form -->
                <div class="flex flex-wrap gap-4 mt-6">
                  <div class="w-1/2">
                    <div id="sq_547" name="question20" class="pr-5">
                      <div class="mb-0">
                        <div
                          role="alert"
                          aria-live="polite"
                          id="sq_547_errors"
                          class="hidden alert alert-danger"
                        >
                        </div>
                        <div class="text-sm">
                          <a
                            href="/applications/4664153/downloads/cr_8"
                            target="_blank"
                            class="text-blue-600 hover:underline"
                          >
                            CLICK HERE TO DOWNLOAD CR-8 <br />SIGN, SCAN AND UPLOAD BELOW
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="w-1/2">
                    <div id="sq_548" aria-labelledby="sq_548_ariaTitle" name="cr8">
                      <h5
                        aria-label="CR-8 Form"
                        id="sq_548_ariaTitle"
                        class="block text-sm font-semibold text-gray-900"
                      >
                        <span class="text-red-500">*</span> CR-8 Form
                      </h5>
                      <div
                        role="alert"
                        aria-live="polite"
                        id="sq_548_errors"
                        class="hidden alert alert-danger"
                      >
                      </div>
                      <div class="mt-2">
                        <input
                          type="file"
                          id="sq_548i"
                          aria-required="true"
                          aria-label="CR-8 Form"
                          class="w-full p-2 border rounded form-input"
                          accept=".pdf"
                        />
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Statement of Nominal Capital -->
                <div class="flex flex-wrap gap-4 mt-6">
                  <div class="w-1/2">
                    <div id="sq_565" name="question10" class="pr-5">
                      <div class="mb-0">
                        <div
                          role="alert"
                          aria-live="polite"
                          id="sq_565_errors"
                          class="hidden alert alert-danger"
                        >
                        </div>
                        <div class="text-sm">
                          <a
                            href="/applications/4664153/downloads/statement_of_nominal_capital"
                            target="_blank"
                            class="text-blue-600 hover:underline"
                          >
                            CLICK HERE TO DOWNLOAD THE STATEMENT OF NOMINAL CAPITAL
                            <br />SIGN, SCAN AND UPLOAD BELOW
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="w-1/2">
                    <div
                      id="sq_566"
                      aria-labelledby="sq_566_ariaTitle"
                      name="statement_of_nominal_capital"
                    >
                      <h5
                        aria-label="block text-sm font-semibold text-gray-900"
                        id="sq_566_ariaTitle"
                        class="block text-sm font-semibold text-gray-900"
                      >
                        <span class="text-red-500">*</span> Statement of Nominal Capital
                      </h5>
                      <div
                        role="alert"
                        aria-live="polite"
                        id="sq_566_errors"
                        class="hidden alert alert-danger"
                      >
                      </div>
                      <div class="mt-2">
                        <input
                          type="file"
                          id="sq_566i"
                          aria-required="true"
                          aria-label="Statement of Nominal Capital"
                          class="w-full p-2 border rounded form-input"
                          accept=".pdf"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
