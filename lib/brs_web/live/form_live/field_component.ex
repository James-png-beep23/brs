defmodule BrsWeb.FormLive.FieldComponent do
  use BrsWeb, :live_component

  import Phoenix.HTML.Form

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("update_field_type", %{"field" => %{"type" => new_field_type}}, socket) do
    {:noreply, assign(socket, :new_field_type, new_field_type)}
  end

  def handle_event(
        "delete_field_option",
        %{"index" => index, "parent_name" => parent_name},
        socket
      ) do
    handle_delete("options", index, parent_name, socket)
  end

  def handle_event(
        "delete_embedded_field",
        %{"index" => index, "parent_name" => parent_name},
        socket
      ) do
    handle_delete("fields", index, parent_name, socket)
  end

  defp handle_delete(type, index, parent_name, socket) do
    index = String.to_integer(index)

    current_params =
      BrsWeb.FormLive.FormComponent.field_to_map(socket.assigns.main_form_field.source.data)

    parent_path = parse_parent_name(parent_name, type)
    updated_params = remove_item_at_path(current_params, parent_path ++ [index])

    updated_changeset =
      Brs.Forms.Field.changeset(socket.assigns.main_form_field.source.data, updated_params)
      |> Map.put(:action, :validate)

    form_field = to_form(updated_changeset)

    send_update(BrsWeb.FormLive.FormComponent,
      id: "brs-form",
      main_form_field: form_field,
      form_field: form_field
    )

    {:noreply, assign(socket, form_field: form_field, main_form_field: form_field)}
  end

  defp remove_item_at_path(params, path) do
    do_remove_item(params, path, [])
  end

  defp do_remove_item(_params, [], acc), do: acc

  defp do_remove_item(params, [key | rest], acc) when is_map(params) do
    Map.update!(params, key, fn value ->
      do_remove_item(value, rest, acc)
    end)
  end

  defp do_remove_item(params, [index | rest], acc) when is_list(params) do
    updated_list =
      case rest do
        [] -> List.delete_at(params, index)
        _ -> List.update_at(params, index, fn value -> do_remove_item(value, rest, acc) end)
      end

    acc ++ updated_list
  end

  defp parse_parent_name(parent_name, type) do
    parent_name
    |> String.split(~r/\]\[|\[|\]/, trim: true)
    |> Enum.reject(&(&1 == "field"))
    |> Enum.map(&convert_key/1)
    |> Enum.map(&replace_form_element(&1, type))
  end

  defp replace_form_element("fields", "fields"), do: "fields"
  defp replace_form_element("options", "options"), do: "options"
  defp replace_form_element(key, _type), do: key

  defp convert_key(key) when is_binary(key) do
    case Integer.parse(key) do
      {int_value, ""} -> int_value
      _ -> key
    end
  end

  defp convert_key(key), do: key
end
