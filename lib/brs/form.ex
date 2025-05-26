defmodule Brs.Form do
  import Ecto.Changeset
  # Define an empty struct, which we will populate dynamically
  defstruct []

  def create_changeset(schema, params \\ %{}) do
    fields =
      Enum.reduce(schema, %{}, fn %Brs.Forms.Page{fields: page_fields}, acc ->
        Enum.reduce(page_fields, acc, fn %Brs.Forms.Field{name: name, type: type}, acc ->
          Map.put(acc, String.to_atom(name), field_type_mapping(type))
        end)
      end)

    types = Map.new(fields, fn {field, type} -> {field, type} end)

    {from_map(fields), types}
    |> cast(params, Map.keys(types))
    |> validate_required(Map.keys(types))
  end

  def change_form_page(form_page, params \\ %{}) do
    fields =
      Enum.reduce(form_page.fields, %{}, fn %Brs.Forms.Field{name: name, type: type}, acc ->
        Map.put(acc, String.to_atom(name), field_type_mapping(type))
      end)

    types = Map.new(fields, fn {field, type} -> {field, type} end)

    {from_map(fields), types}
    |> cast(params, Map.keys(types))
    |> validate_required(Map.keys(types))
  end

  defp from_map(field_map) do
    struct(__MODULE__, field_map)
  end

  defp field_type_mapping("textbox"), do: :string
  defp field_type_mapping("checkbox"), do: :boolean
  defp field_type_mapping("select"), do: :string
  defp field_type_mapping("radio"), do: :string
  # Default type
  defp field_type_mapping(_), do: :string
end
