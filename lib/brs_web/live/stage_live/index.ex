defmodule BrsWeb.StageLive.Index do
  use BrsWeb, :live_view

  alias Brs.Stages
  alias Brs.Stages.Stage

  @impl true
  def mount(_params, session, socket) do
    live_action = session["live_action"] || :index

    service_id = session["service_id"] |> String.to_integer()

    stages = Stages.list_stages(service_id)
    {:ok,
     stream(socket, :stages, stages)
     |> assign(:live_action, live_action)
     |> assign(:service_id, service_id)
    }
  end

  def handle_event("new", _params, socket) do
    {:noreply, assign_stage(:new, socket)}
  end

  def handle_event("edit", %{"id" => id} = _params, socket) do
    stage = Stages.get_stage!(id)
    {:noreply, assign_stage(:edit, socket, stage)}
  end

  defp assign_stage(action, socket, stage \\ %Stage{}) do
    page_title =
      case action do
        :new -> "New Stage"
        :edit -> "Edit Stage"
      end
    socket
    |> assign(:page_title, page_title)
    |> assign(:stage, stage)
    |> assign(:live_action, action)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    delete_stage(id, socket)
  end

  def delete_stage(id, socket) do
    stage = Stages.get_stage!(id)

    case Stages.delete_stage(stage) do
      {:ok, _stage} ->
        socket = socket
          |> put_flash(:info, "Stage deleted successfully")
          |> assign(:stages, Stages.list_stages(stage.service_id))
        {:noreply, socket}

      {:error, _reason} ->
        {:noreply, socket |> put_flash(:error, "Failed to delete stage.")}
    end
  end

  def handle_info({BrsWeb.StageLive.FormComponent , {:saved, msg}}, socket) do
    {:noreply,
     socket
     |> assign(:live_action, :index)
     |> put_flash(:info, msg)
     |> stream(
       :stages,
       Stages.list_stages(socket.assigns.service_id)
     )}
  end
end
