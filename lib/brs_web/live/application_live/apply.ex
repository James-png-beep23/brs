defmodule BrsWeb.ApplicationLive.Apply do
  alias Brs.{Forms, Services, Applications}
  use BrsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_info({"make-application", form_data}, socket) do
    form_data =
      case socket.assigns[:current_application] do
        nil ->
          form_data

        appl ->
          Map.merge(appl.form_data, form_data)
      end

    socket
    |> make_application(form_data)
    |> case do
      {:ok, appl} ->
        {:noreply,
         socket
         |> put_flash(:info, "Application created successfully")
         |> push_navigate(to: ~p"/applications/#{appl.id}")}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_info({:save_draft, form_data}, socket) do
    socket
    |> make_application(form_data)
    |> case do
      {:ok, appl} ->
        current_step = socket.assigns.current_step + 1

        {:noreply,
         socket
         |> assign(:current_application, appl)
         |> assign(:current_step, current_step)
         |> put_flash(:info, "Application draft created successfully")
         |> push_patch(to: ~p"/applications/#{appl.id}/edit?step=#{current_step}")}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_info({:prev_step, prev_step}, socket) do
    appl = socket.assigns.current_application

    {:noreply,
     assign(socket, :current_step, prev_step)
     |> push_patch(to: ~p"/applications/#{appl.id}/edit?step=#{prev_step}")}
  end

  defp apply_action(socket, :apply, %{"id" => service_id}) do
    {:noreply,
     socket
     |> new_application(service_id)}
  end

  defp apply_action(socket, :edit, %{"id" => application_id} = params) do
    step =
      case params["step"] do
        nil ->
          1

        step ->
          {step, _} = Integer.parse(step)
          step
      end

    {:noreply,
     socket
     |> assign(:current_step, step)
     |> edit_application(application_id)}
  end

  defp new_application(socket, service_id) do
    service = Services.get_service!(service_id)
    schema = Enum.at(service.form.schema.pages, 0)
    changeset = Forms.change_schema_page(schema)

    socket
    |> assign(:current_step, 1)
    |> assign(:pages, service.form.schema.pages)
    |> assign(form: to_form(changeset))
    |> assign(form_schema: schema)
    |> assign(service: service)
  end

  defp make_application(socket, form_data) do
    user = socket.assigns.current_user
    user_account = socket.assigns.current_account
    service = socket.assigns.current_service

    case socket.assigns[:current_application] do
      nil ->
        Applications.create_application(service, user_account, form_data, user)

      appl ->
        form_data = Map.merge(appl.form_data, form_data)

        appl
        |> Applications.update(%{form_data: form_data})
    end
  end

  defp edit_application(socket, application_id) do
    appl =
      Applications.get_application!(application_id)
      |> Applications.preload_form()
      |> Applications.preload_service()

    schema =
      Enum.at(appl.form.schema.pages, socket.assigns.current_step) ||
        Enum.at(appl.form.schema.pages, 0)

    changeset =
      Forms.change_dynamic_form(appl.form.schema, appl.form_data)

    socket
    |> assign(:current_step, socket.assigns.current_step)
    |> assign(current_application: appl)
    |> assign(:pages, appl.form.schema.pages)
    |> assign(form_schema: schema)
    |> assign(form: to_form(changeset))
    |> assign(service: appl.service)
  end

  defp get_component_module(fields) do
    fields
    |> Enum.find_value(BrsWeb.Components.FormRenderer, fn
      %Brs.Forms.Field{type: type} ->
        case resolve_component(type) do
          BrsWeb.Components.FormRenderer -> nil
          component -> component
        end
    end)
  end

  defp resolve_component("plc"), do: BrsWeb.Forms.Plc.FormComponent
  defp resolve_component("pvt"), do: BrsWeb.Forms.Pvt.FormComponent
  defp resolve_component(_), do: BrsWeb.Components.FormRenderer
end
