defmodule BrsWeb.TaskLive.Show do
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> initialize_tabs()}
  end

  @impl true
  def handle_params(%{"id" => _id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))}
  end

  @impl true
  def handle_event("switch_appl_detail_tab", %{"index" => index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     socket
     |> assign(active_appl_detail_tab: index)}
  end

  def handle_event("switch_other_appl_detail_tab", %{"index" => index}, socket) do
    index = String.to_integer(index)

    {:noreply,
     socket
     |> assign(active_other_appl_detail_tab: index)}
  end

  defp initialize_tabs(socket) do
    appl_detail_tabs = [
      %{id: 1, title: ~c"Proposed Names"},
      %{id: 2, title: ~c"Applicant"},
      %{id: 3, title: ~c"Articles of Association"},
      %{id: 4, title: ~c"Registered Address"},
      %{id: 5, title: ~c"Business Activity"},
      %{id: 6, title: ~c"Share Information"},
      %{id: 7, title: ~c"Ownership"},
      %{id: 8, title: ~c"Attachments"}
    ]

    other_appl_detail_tabs = [
      %{id: 1, title: ~c"Application Details"},
      %{id: 2, title: ~c"Comments"},
      %{id: 3, title: ~c"Corrections"},
      %{id: 4, title: ~c"Audit Trail"},
      %{id: 5, title: ~c"Commands"},
      %{id: 6, title: ~c"Stages"},
      %{id: 7, title: ~c"Ledger"},
      %{id: 8, title: ~c"Transfers"},
      %{id: 9, title: ~c"Callbacks"}
    ]

    assign(socket,
      appl_detail_tabs: appl_detail_tabs,
      other_appl_detail_tabs: other_appl_detail_tabs,
      active_appl_detail_tab: 0,
      active_other_appl_detail_tab: 0
    )
  end

  defp page_title(:show), do: "Review Task"
end
