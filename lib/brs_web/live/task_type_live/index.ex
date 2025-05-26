defmodule BrsWeb.TaskTypeLive.Index do
  use BrsWeb, :live_view

  alias Brs.TaskTypes
  alias Brs.TaskTypes.TaskType

  @impl true
  def mount(_params, %{"service_id" => service_id} = session, socket) do
    live_action = session["live_action"] || :index

    {:ok,
     socket
     |> assign(
       :task_types,
       TaskTypes.list_task_types(service_id)
       |> TaskTypes.preload_service()
     )
     |> assign(:show_form, false)
     |> assign(:service_id, service_id)
     |> assign(:show_list, true)
     |> assign(:live_action, live_action)}
  end

  def handle_params(params, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task type")
    |> assign(:task_type, TaskTypes.get_task_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task type")
    |> assign(:task_type, %TaskType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Task types")
    |> assign(:task_type, nil)
  end

  @impl true
  def handle_info({BrsWeb.TaskTypeLive.FormComponent, {:saved, msg}}, socket) do
    {:noreply,
     socket
     |> assign(:live_action, :index)
     |> assign(:show_form, false)
     |> put_flash(:info, msg)
     |> assign(
       :task_types,
       TaskTypes.list_task_types(socket.assigns.service_id)
       |> TaskTypes.preload_service()
     )}
  end

  @impl true
  def handle_event("task-types", _params, socket) do
    {:noreply,
     assign(socket, :task_type, %TaskType{})
     |> assign(:live_action, :new)
     |> assign(:page_title, "New Task Type")
     |> assign(:show_form, true)}
  end

  @impl true
  def handle_event("edit-task-types", %{"id" => id}, socket) do
    task_type = TaskTypes.get_task_type!(id)

    {:noreply,
     assign(socket, :task_type, task_type)
     |> assign(:show_form, true)
     |> assign(:show_list, false)
     |> assign(:page_title, "Edit Task Type")
     |> assign(:live_action, :edit)}
  end

  @impl true
  def handle_event("show-action", %{"id" => id}, socket) do
    {:noreply,
     assign(socket, :task_type, TaskTypes.get_task_type!(id))
     |> assign(:page_title, "Show")
     |> assign(:live_action, :show)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task_type = TaskTypes.get_task_type!(id)
    {:ok, _} = TaskTypes.delete_task_type(task_type)

    {:noreply, stream_delete(socket, :task_types, task_type)}
  end

  def handle_event("close-modal", _params, socket) do
    {:noreply,
     socket
     |> assign(:show_form, false)}
  end

  def handle_event("back", %{"service_id" => service_id}, socket) do

      {:noreply,
       socket
       |> assign(:live_action, :index)
       |> assign(:show_list, true)
       |> assign(:show_form, false)
       |> stream(:task_types, get_task_types(service_id))}
  end

  defp get_task_types(service_id) do
    TaskTypes.list_task_types(service_id)
    |> TaskTypes.preload_service()
  end
end
