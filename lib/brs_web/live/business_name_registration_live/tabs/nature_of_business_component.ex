defmodule BrsWeb.BusinessNameRegistrationLive.Tabs.NatureOfBusinessComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
          <h3 class="text-lg font-bold mb-2">Nature of Business</h3>
          <div class="m-5">
                <input type="text" id="nature_of_business"
                class="text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
                placeholder="Nature of Business" required />
              </div>
      </div>
    """
  end
end
