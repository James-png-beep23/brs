defmodule BrsWeb.OutputTemplateLive.Index do
  use BrsWeb, :live_view

  alias Brs.OutputTemplates
  alias Brs.OutputTemplates.OutputTemplate

  @impl true
  def mount(_params, %{"service_id" => service_id} = session, socket) do
    
    live_action = session["live_action"] || :index
    output_templates = OutputTemplates.list_output_templates(service_id)

    {:ok,
     stream(socket, :output_templates, output_templates)
     |> assign(:live_action, live_action)
     |> assign(:service_id, service_id)}
  end

  @impl true
  def handle_info({BrsWeb.OutputTemplateLive.FormComponent, {:saved, msg}}, socket) do
    {:noreply,
     socket
     |> assign(:live_action, :index)
     |> put_flash(:info, msg)
     |> stream(
       :output_templates,
       OutputTemplates.list_output_templates(socket.assigns.service_id)
     )}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    output_template = OutputTemplates.get_output_template!(id)
    {:ok, _} = OutputTemplates.delete_output_template(output_template)

    {:noreply,
     stream_delete(
       socket,
       :output_templates,
       OutputTemplates.list_output_templates(socket.assigns.service_id)
     )}
  end

  def handle_event("add-output", _params, socket) do
    {:noreply, assign_template(:new, socket)}
  end

  def handle_event("edit-output", %{"id" => id} = _params, socket) do
    template = OutputTemplates.get_output_template!(id)
    {:noreply, assign_template(:edit, socket, template)}
  end

  def handle_event("back", %{"id" => id} = _params, socket) do
    output_templates = OutputTemplates.list_output_templates(id)

    {:noreply,
     socket
     |> assign(:live_action, :index)
     |> stream(:output_templates, output_templates)}
  end

  defp assign_template(action, socket, template \\ %OutputTemplate{}) do
    page_title =
      case action do
        :new -> "New Output"
        :edit -> "Edit Output"
      end

    socket
    |> assign(:page_title, page_title)
    |> assign(:output_template, template)
    |> assign(:live_action, action)
  end
end
