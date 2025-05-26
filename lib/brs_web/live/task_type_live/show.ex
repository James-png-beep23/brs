defmodule BrsWeb.TaskTypeLive.Show do
  alias Brs.TaskTypes.Role
  alias Brs.TaskTypes.Action
  use BrsWeb, :live_view

  alias Brs.TaskTypes

  @impl true
  def mount(_params, %{"task_type_id" => task_type_id} = session, socket) do
    {:ok,
     socket
     |> assign(:task_type, get_task_type(task_type_id))
     |> assign(:service_id, session["service_id"])
     |> assign(:show_action_modal, false)
     |> assign(:show_role_modal, false)}
  end

  def handle_event("add-action", _params, socket) do
    {:noreply,
     socket
     |> assign(:live_action, :new)
     |> assign(:show_action_modal, true)
     |> assign(:task_type_action, %Action{})
     |> assign(:page_title, "Add Action")}
  end

  def handle_event("add-roles", _params, socket) do
    {:noreply,
     socket
     |> assign(:live_action, :new)
     |> assign(:show_role_modal, true)
     |> assign(:task_type_role, %Role{})
     |> assign(:page_title, "Add Role")}
  end

  def handle_event("edit-action", %{"id" => action_id}, socket) do
    action = TaskTypes.get_action!(action_id)

    {:noreply,
     socket
     |> assign(:live_action, :edit)
     |> assign(:show_action_modal, true)
     |> assign(:task_type_action, action)
     |> assign(:page_title, "Edit Action")}
  end

  def handle_event("edit-roles", %{"id" => role_id}, socket) do
    role = TaskTypes.get_role!(role_id)

    {:noreply,
     socket
     |> assign(:live_action, :edit)
     |> assign(:show_role_modal, true)
     |> assign(:task_type_role, role)
     |> assign(:page_title, "Edit Roles")}
  end

  def handle_event("toggle-modal", %{"action-modal" => action_modal}, socket) do
    {:noreply, socket |> assign(:show_action_modal, !action_modal)}
  end

  def handle_event("toggle-modal", %{"role-modal" => role_modal}, socket) do
    {:noreply, socket |> assign(:show_role_modal, !role_modal)}
  end

  def handle_event("toggle_dropdown", _params, socket) do
    {:noreply, assign(socket, :dropdown_open, !socket.assigns.dropdown_open)}
  end

  @impl true
  def handle_event("delete-role", %{"id" => id}, socket) do
    task_type_role = TaskTypes.get_role!(id)
    {:ok, _} = TaskTypes.delete_role(task_type_role)

    {:noreply, assign(socket, :task_type, get_task_type(task_type_role.task_type_id))}
  end

  @impl true
  def handle_event("delete-action", %{"id" => id}, socket) do
    task_type_action = TaskTypes.get_action!(id)
    {:ok, _} = TaskTypes.delete_action(task_type_action)

    {:noreply, assign(socket, :task_type, get_task_type(task_type_action.task_type_id))}
  end

  @impl true
  def handle_info({BrsWeb.TaskTypeLive.ActionFormComponent, {:saved, action}}, socket) do
    {:noreply,
     assign(socket, :task_type, get_task_type(action.task_type_id))
     |> assign(:show_action_modal, false)}
  end

  @impl true
  def handle_info({BrsWeb.TaskTypeLive.RoleFormComponent, {:saved, role}}, socket) do
    {:noreply,
     assign(
       socket,
       :task_type,
       get_task_type(role.task_type_id) |> assign(:show_role_modal, false)
     )}
  end

  defp get_task_type(task_type_id) do
    TaskTypes.get_task_type!(task_type_id)
    |> TaskTypes.preload_actions()
    |> TaskTypes.preload_roles()
  end
end
