defmodule Brs.Helpers do
  require Logger

  @doc """
  Removes trailing commas in JSON string
  """
  @trailing_comas ~r/,(?!\s*?[{["\w])|(?<=[{[]),/
  def json_trim_extra_commas(json_string) do
    @trailing_comas
    |> Regex.replace(json_string, "")
  end

  def print_changeset_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
    |> Enum.each(fn {field, messages} ->
      Logger.error("#{field}: #{Enum.join(messages, ", ")}")
    end)
  end

  defp translate_error({msg, _opts}) do
    msg
  end

  def struct_to_map(struct) when is_struct(struct) do
    struct
    |> Map.from_struct()
    |> Enum.into(%{}, fn {key, value} ->
      {key, struct_to_map(value)}
    end)
  end

  def struct_to_map(value) when is_list(value) do
    Enum.map(value, &struct_to_map/1)
  end

  def struct_to_map(value), do: value

  def atomize_keys(map) when is_map(map) do
    map
    |> Enum.map(fn
      {key, value} when is_binary(key) -> {String.to_atom(key), atomize_keys(value)}
      {key, value} -> {key, atomize_keys(value)}
    end)
    |> Enum.into(%{})
  end

  def atomize_keys(list) when is_list(list), do: Enum.map(list, &atomize_keys/1)
  def atomize_keys(value), do: value

  def stringify_keys(map) when is_map(map) do
    map
    |> Map.new(fn {key, value} -> {to_string(key), stringify_value(value)} end)
  end

  defp stringify_value(value) when is_map(value), do: stringify_keys(value)
  defp stringify_value(value), do: value
end
