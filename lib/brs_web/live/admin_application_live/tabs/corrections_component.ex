defmodule BrsWeb.AdminApplicationLive.CorrectionsComponent do
  use BrsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div class="grid grid-cols-4 bg-white overflow-hidden shadow-sm rounded-lg p-6">
        <h2>Corrections</h2>
      </div>
    </div>
    """
  end
end
