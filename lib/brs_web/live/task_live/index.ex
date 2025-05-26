defmodule BrsWeb.TaskLive.Index do
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> initialize_tabs()}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Tasks")
  end

  @impl true
  def handle_event("switch_tab", %{"key" => key}, socket) do
    key = String.to_atom(key)

    {:noreply,
     socket
     |> assign(active_tab: key)}
  end

  defp initialize_tabs(socket) do
    tabs = [
      %{key: :queue, title: ~c"Queue", tasks_count: 0},
      %{key: :inbox, title: ~c"Inbox", tasks_count: 4},
      %{key: :processing, title: ~c"Processing", tasks_count: 2},
      %{key: :corrections, title: ~c"Corrections", tasks_count: 5},
      %{key: :complete, title: ~c"Complete", tasks_count: 3}
    ]

    assign(socket, tabs: tabs, active_tab: :queue)
  end
end
