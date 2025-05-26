defmodule BrsWeb.FormLive.FormComponent do
  use BrsWeb, :live_component

  alias Brs.Forms
  alias Brs.Forms.{Form, Schema, Page, Field, Option}

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> maybe_initialize_form(assigns)
      |> maybe_update_form_field(assigns)
      |> maybe_update_form_field_action(assigns)

    {:ok, socket}
  end

  defp maybe_initialize_form(socket, %{form: form}) do
    socket =
      case form do
        %Form{} ->
          changeset = Forms.change_form(form)

          initial_assigns = %{
            current_form_page: 0,
            form_page: initialize_current_page(form, 0),
            form_field: Forms.change_form_field(%Field{}),
            form_field_action: :none,
            form_field_index: nil
          }

          assign_form(socket, changeset)
          |> assign(initial_assigns)

        _ ->
          assign(socket, form: form)
      end

    socket
  end

  defp maybe_initialize_form(socket, _), do: socket

  defp maybe_update_form_field(socket, %{form_field: form_field}) do
    assign(socket, form_field: form_field)
  end

  defp maybe_update_form_field(socket, _), do: socket

  defp maybe_update_form_field_action(socket, %{form_field_action: form_field_action}) do
    assign(socket, form_field_action: form_field_action)
  end

  defp maybe_update_form_field_action(socket, _), do: socket

  @impl true
  def handle_event("add_form_page", _params, socket) do
    form =
      if Map.has_key?(socket.assigns.form, :source) and socket.assigns.form.source.valid? do
        socket.assigns.form.data
      else
        map_to_form_struct(socket.assigns.form.params)
      end

    updated_schema =
      update_schema_pages(
        form.schema,
        &(&1 ++ [%Page{title: "Untitled Page", fields: []}])
      )

    form_changeset =
      form
      |> Form.changeset(%{})
      |> Ecto.Changeset.put_embed(:schema, updated_schema, on_replace: :update)

    updated_form = %{socket.assigns.form | data: Ecto.Changeset.apply_changes(form_changeset)}

    last_index = Enum.count(updated_form.data.schema.pages) - 1

    {:noreply,
     assign(socket,
       form: updated_form,
       current_form_page: last_index,
       form_page: initialize_current_page(updated_form.data, last_index)
     )}
  end

  def handle_event("switch_form_page", %{"index" => index}, socket) do
    index = String.to_integer(index)

    current_page =
      socket.assigns.form.data.schema.pages
      |> Enum.at(index)
      |> Forms.change_form_page()
      |> to_form()

    {:noreply,
     socket
     |> assign(current_form_page: index)
     |> assign(form_field_action: :none)
     |> assign(form_page: current_page)
     |> assign(form_field: Forms.change_form_field(%Field{}))}
  end

  def handle_event("delete_form_page", _params, socket) do
    index = socket.assigns.current_form_page

    updated_schema =
      update_schema_pages(socket.assigns.form.data.schema, &List.delete_at(&1, index))

    form_changeset =
      socket.assigns.form.data
      |> Form.changeset(%{})
      |> Ecto.Changeset.put_embed(:schema, %{pages: updated_schema.pages}, on_replace: :update)

    updated_form = %{socket.assigns.form | data: Ecto.Changeset.apply_changes(form_changeset)}

    {:noreply,
     assign(socket,
       form: updated_form,
       current_form_page: 0,
       form_page: initialize_current_page(updated_form.data, 0)
     )}
  end

  def handle_event("add_new_form_field", _params, socket) do
    form_field = %Field{} |> Forms.change_form_field() |> to_form(action: :validate)
    {:noreply, assign(socket, form_field_action: :new, form_field: form_field)}
  end

  def handle_event("cancel_form_field_edit", _params, socket) do
    {:noreply, assign(socket, :form_field_action, :none)}
  end

  def handle_event("edit_form_field", %{"index" => index}, socket) do
    index = String.to_integer(index)

    current_page =
      socket.assigns.form.data.schema.pages |> Enum.at(socket.assigns.current_form_page)

    form_field =
      current_page.fields
      |> Enum.at(index)
      |> Forms.change_form_field()
      |> to_form(action: :validate)

    {:noreply,
     assign(socket, form_field_action: :edit, form_field_index: index, form_field: form_field)}
  end

  def handle_event("delete_form_field", %{"index" => index}, socket) do
    index = String.to_integer(index)

    current_page =
      socket.assigns.form.data.schema.pages |> Enum.at(socket.assigns.current_form_page)

    updated_fields = List.delete_at(current_page.fields, index)
    updated_page = %{current_page | fields: updated_fields}

    updated_schema =
      update_schema_pages(socket.assigns.form.data.schema, fn pages ->
        List.update_at(pages, socket.assigns.current_form_page, fn _ -> updated_page end)
      end)

    form_changeset =
      socket.assigns.form.data
      |> Form.changeset(%{})
      |> Ecto.Changeset.put_embed(:schema, updated_schema, on_replace: :update)

    updated_form = %{socket.assigns.form | data: Ecto.Changeset.apply_changes(form_changeset)}

    {:noreply, assign(socket, :form, updated_form)}
  end

  def handle_event("validate_form_field", %{"field" => field_params}, socket) do
    form_field =
      socket.assigns.form_field.source.data
      |> Forms.change_form_field(field_params)
      |> to_form(action: :validate)

    {:noreply, assign(socket, :form_field, form_field)}
  end

  def handle_event("save_form_field", %{"field" => form_field_params}, socket) do
    save_form_field(socket, socket.assigns.form_field_action, form_field_params)
  end

  def handle_event("validate_form_page", %{"page" => %{"title" => title}} = page_params, socket) do
    form_page = socket.assigns.form_page.data
    page_index = socket.assigns.current_form_page

    updated_schema =
      update_schema_pages(socket.assigns.form.data.schema, fn pages ->
        List.update_at(pages, page_index, fn page ->
          %Page{
            title: title,
            fields: page.fields
          }
        end)
      end)

    form_changeset =
      socket.assigns.form.data
      |> Form.changeset(%{})
      |> Ecto.Changeset.put_embed(:schema, %{pages: updated_schema.pages}, on_replace: :update)

    updated_form = %{socket.assigns.form | data: Ecto.Changeset.apply_changes(form_changeset)}

    form_page = form_page |> Forms.change_form_page(page_params) |> to_form(action: :validate)

    {:noreply, assign(socket, form_page: form_page, form: updated_form)}
  end

  def handle_event("validate_form", %{"form" => form_params}, socket) do
    form = socket.assigns.form.data |> Forms.change_form(form_params) |> to_form()
    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("save", %{"form" => form_params}, socket) do
    save_form(socket, socket.assigns.action, form_params)
  end

  defp save_form_field(socket, form_field_action, form_field_params) do
    form_field = socket.assigns.form_field

    if Map.has_key?(form_field, :source) and form_field.source.valid? do
      form = socket.assigns.form.data
      form = if form.schema == nil, do: initialize_schema(form), else: form

      current_page = form.schema.pages |> Enum.at(socket.assigns.current_form_page)

      updated_fields =
        case form_field_action do
          :new ->
            current_page.fields ++
              [BrsWeb.FormLive.FormComponent.map_to_field_struct(form_field_params)]

          :edit ->
            List.update_at(current_page.fields, socket.assigns.form_field_index, fn _ ->
              BrsWeb.FormLive.FormComponent.map_to_field_struct(form_field_params)
            end)
        end

      updated_page = %{current_page | fields: updated_fields}

      updated_schema =
        BrsWeb.FormLive.FormComponent.update_schema_pages(form.schema, fn pages ->
          List.update_at(pages, socket.assigns.current_form_page, fn _ -> updated_page end)
        end)

      form_changeset =
        form
        |> Form.changeset(%{})
        |> Ecto.Changeset.put_embed(:schema, updated_schema, on_replace: :update)

      form = %{socket.assigns.form | data: Ecto.Changeset.apply_changes(form_changeset)}

      {:noreply,
       assign(socket,
         form: form,
         form_field_action: :none,
         form_field: Forms.change_form_field(%Field{})
       )}
    else
      {:noreply, assign(socket, :form_field, form_field)}
    end
  end

  defp save_form(socket, action, form_params) when action in [:new, :edit] do
    form = socket.assigns.form

    form_params =
      if form.data.schema do
        Map.put(form_params, "schema", %{
          "pages" => Enum.map(form.data.schema.pages, &page_to_map/1)
        })
      else
        form_params
      end

    case action do
      :new ->
        case Forms.create_form(form_params) do
          {:ok, form} ->
            notify_parent({:saved, form})

            {:noreply,
             socket
             |> put_flash(:info, "Form created successfully")
             |> redirect(to: "/system/forms")}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, form: to_form(changeset))}
        end

      :edit ->
        case Forms.update_form(form.data, form_params) do
          {:ok, form} ->
            notify_parent({:saved, form})

            {:noreply,
             socket
             |> put_flash(:info, "Form updated successfully")
             |> redirect(to: "/system/forms")}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign_form(socket, changeset)}
        end
    end
  end

  def update_schema_pages(schema, update_fn) do
    pages = update_fn.(schema.pages)
    %{schema | pages: pages}
  end

  defp initialize_current_page(form, index) do
    if not is_nil(form.schema.pages) and length(form.schema.pages) > 0 do
      form.schema.pages
      |> Enum.at(index)
      |> Forms.change_form_page()
      |> to_form()
    else
      %Page{}
    end
  end

  defp initialize_schema(form) do
    schema = %Schema{
      pages: [%Page{title: "Untitled Page", fields: []}]
    }

    Ecto.Changeset.put_embed(form, :schema, schema, on_replace: :update)
    |> Ecto.Changeset.apply_changes()
  end

  defp notify_parent(message), do: send(self(), {__MODULE__, message})

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp map_to_form_struct(%{"schema" => %{"pages" => pages}} = params) do
    %Form{
      name: params["name"],
      schema: %Schema{
        pages: Enum.map(pages, &map_to_page_struct/1)
      }
    }
  end

  defp map_to_form_struct(params) do
    %Form{
      name: params["name"],
      schema: %Schema{pages: []}
    }
  end

  defp map_to_page_struct(%{"fields" => fields} = params) do
    %Page{
      title: params["title"],
      fields: Enum.map(Map.values(fields), &map_to_field_struct/1)
    }
  end

  defp map_to_page_struct(params) do
    %Page{
      title: params["title"]
    }
  end

  def map_to_field_struct(%{"options" => options} = params) do
    %Field{
      name: params["name"],
      label: params["label"],
      type: params["type"],
      options: Enum.map(Map.values(options), &map_to_option_struct/1)
    }
  end

  def map_to_field_struct(%{"fields" => fields} = params) do
    %Field{
      name: params["name"],
      label: params["label"],
      type: params["type"],
      fields: Enum.map(Map.values(fields), &map_to_field_struct/1)
    }
  end

  def map_to_field_struct(params) do
    %Field{
      name: params["name"],
      label: params["label"],
      type: params["type"]
    }
  end

  def map_to_option_struct(params) do
    %Option{
      label: params["label"],
      value: params["value"]
    }
  end

  defp page_to_map(%Page{} = page) do
    %{
      "title" => page.title,
      "fields" => Enum.map(page.fields, &field_to_map/1)
    }
  end

  def field_to_map(%Field{} = field) do
    %{
      "name" => field.name,
      "label" => field.label,
      "type" => field.type,
      "options" => Enum.map(field.options, &option_to_map/1),
      "fields" => Enum.map(field.fields, &field_to_map/1)
    }
  end

  defp option_to_map(%Option{} = option) do
    %{
      "label" => option.label,
      "value" => option.value
    }
  end
end
