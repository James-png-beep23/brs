defmodule BrsWeb.FormLive.Index do
  alias Brs.Forms.{Form, Schema}
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Form")
    |> assign(:form, %Form{schema: %Schema{pages: []}})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Form")
    |> assign(:form, Brs.Repo.get!(Form, id))
  end

  @impl true
  def handle_info({BrsWeb.FormLive.FormComponent, {:saved, _form}}, socket) do
    {:noreply, socket}
  end

  defp header_title(:new), do: "New Form"
  defp header_title(:edit), do: "Edit Form"
end
