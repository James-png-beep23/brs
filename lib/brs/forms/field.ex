defmodule Brs.Forms.Field do
  use Ecto.Schema

  import Ecto.Changeset

  alias Brs.Forms.{Field, Option}

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:label, :string)
    field(:type, :string)
    embeds_many(:fields, Field, on_replace: :delete)
    embeds_many(:options, Option, on_replace: :delete)
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :name,
      :label,
      :type
    ])
    |> validate_required([:name, :label, :type])
    |> validate_inclusion(:type, [
      "textbox",
      "textarea",
      "dropdown",
      "radiobuttons",
      "checklist",
      "panel",
      "dynamic_panel",
      "plc",
      "pvt"
    ])
    |> maybe_convert_params("fields", "fields_sort")
    |> maybe_convert_params("fields", "fields_drop")
    |> maybe_convert_params("options", "options_sort")
    |> maybe_convert_params("options", "options_drop")
    |> cast_by_type()
  end

  defp cast_by_type(changeset) do
    get_field(changeset, :type)
    |> cast_by_type(changeset)
  end

  defp cast_by_type("panel", changeset) do
    cast_embed(changeset, :fields,
      required: true,
      with: &changeset/2,
      sort_param: :fields_sort,
      drop_param: :fields_drop
    )
  end

  defp cast_by_type("dynamic_panel", changeset) do
    cast_embed(changeset, :fields,
      required: true,
      with: &changeset/2,
      sort_param: :fields_sort,
      drop_param: :fields_drop
    )
  end

  defp cast_by_type(type, changeset)
       when type in ["dropdown", "radiobuttons", "checklist"] do
    cast(changeset, changeset.params, [])
    |> cast_embed(:options,
      with: &Option.changeset/2,
      required: true,
      sort_param: :options_sort,
      drop_param: :options_drop
    )
  end

  defp cast_by_type(_, changeset), do: changeset

  defp maybe_convert_params(changeset, key, subkey) do
    case Map.get(changeset.params, key, Map.new()) do
      %{} = fields when map_size(fields) > 0 ->
        value = Map.get(fields, subkey)

        if is_list(value) do
          %{changeset | params: put_in(changeset.params, [key, subkey], %{subkey => value})}
        else
          changeset
        end

      _ ->
        changeset
    end
  end
end
