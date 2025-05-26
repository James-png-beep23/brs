defmodule BrsWeb.BrsComponents do
  @moduledoc """
  Provides BRS UI components.
  """
  import Phoenix.HTML
  import Phoenix.HTML.Tag
  import Phoenix.HTML.Form
  import BrsWeb.CoreComponents

  use Phoenix.Component

  @doc """
  Renders a BRS input with label and error messages.

  ## Examples

      <.brs_input field={@form[:email]} type="textbox" />
      <.brs_input name="my-input" errors={["oh no!"]} />
  """
  attr :id, :any, default: nil
  attr :name, :any, default: nil
  attr :label, :string, default: nil
  attr :value, :any

  attr :type, :string,
    default: "textbox",
    values: ~w(textbox textarea checklist dropdown radiobuttons hidden checkbox select)

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :errors, :list, default: []
  attr :options, :list, doc: "the options to pass to render_options/2 or render_options/3"
  attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block

  def brs_input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> brs_input()
  end

  def brs_input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("checkbox", assigns[:value])
      end)

    ~H"""
    <div phx-feedback-for={@name}>
      <label class="flex items-center gap-4 text-sm leading-6 text-zinc-600">
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value={@value}
          checked={@checked}
          class="rounded border-zinc-300 text-zinc-900 focus:ring-0"
          {@rest}
        />
        <%= @label %>
      </label>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "checklist"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}><%= @label %></.brs_label>
      <%= render_options(@options, @type) %>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "radiobuttons"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}><%= @label %></.brs_label>
      <%= render_options(@options, @type, @name) %>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "dropdown"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}>
        <%= @label %> <span :if={@rest[:required]} aria-hidden="true" class="text-red-500 ml-1">*</span>
      </.brs_label>
      <select
        id={@id}
        class="block w-full mt-2 bg-white border border-gray-300 rounded-md shadow-sm focus:border-zinc-400 focus:ring-0 sm:text-sm"
        {@rest}
      >
        <option value="">Select <%= @label %>...</option>
        <%= render_options(@options, @type) %>
      </select>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <.brs_label for={@id}>
        <%= @label %> <span :if={@rest[:required]} aria-hidden="true" class="text-red-500 ml-1">*</span>
      </.brs_label>
      <select
        id={@id}
        name={@name}
        class="block w-full mt-2 bg-white border border-gray-300 rounded-md shadow-sm focus:border-zinc-400 focus:ring-0 sm:text-sm"
        multiple={@multiple}
        {@rest}
      >
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "textarea"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}><%= @label %></.brs_label>
      <textarea
        id={@id}
        class={[
          "mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
          "min-h-[6rem] phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400"
        ]}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", "") %></textarea>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "panel"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}><%= @label %></.brs_label>
      <div class="block w-full p-4 mt-2 mb-4 bg-white border border-gray-300 rounded-md rounded-lg shadow-md">
        Panel
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def brs_input(%{type: "dynamic_panel"} = assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}><%= @label %></.brs_label>
      <div class="block w-full p-4 mt-2 mb-4 bg-white border border-gray-300 rounded-md rounded-lg shadow-md">
        Dynamic Panel
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  # All other inputs textbox etc. are handled here...
  def brs_input(assigns) do
    ~H"""
    <div class="flex flex-col items-start">
      <.brs_label for={@id}>
        <%= @label %> <span :if={@rest[:required]} aria-hidden="true" class="text-red-500 ml-1">*</span>
      </.brs_label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={[
          "px-3 py-2 mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
          "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400 border",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400"
        ]}
        {@rest}
      />
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  @doc """
  Renders a label.
  """
  attr :for, :string, default: nil
  slot :inner_block, required: true

  def brs_label(assigns) do
    ~H"""
    <label for={@for} class="block text-sm font-semibold leading-6 text-zinc-800">
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  @doc """
  Generates an error component for a form field.
  """
  def error_tag(form, field) do
    form.errors
    |> Keyword.get_values(field)
    |> Enum.map(fn error ->
      content_tag(:span, translate_error(error),
        class: "text-rose-600",
        phx_feedback_for: input_id(form, field)
      )
    end)
  end

  def render_options(options, "dropdown" = _type) do
    escaped_options =
      options
      |> Enum.map(fn %Brs.Forms.Option{label: label, value: value} ->
        safe_to_string(content_tag(:option, label, value: value))
      end)

    {:safe, escaped_options}
  end

  def render_options(options, "checklist" = _type) do
    escaped_options =
      options
      |> Enum.map(fn %Brs.Forms.Option{label: label, value: _value} ->
        safe_to_string(
          content_tag(:label, class: "flex items-center gap-4 text-sm leading-6 text-zinc-600") do
            hidden_input = content_tag(:input, "", type: "hidden", value: "false")

            checkbox_input =
              content_tag(:input, "",
                type: "checkbox",
                value: "true",
                class: "rounded border-zinc-300 text-zinc-900 focus:ring-0"
              )

            label_text = Phoenix.HTML.raw(label)

            [hidden_input, checkbox_input, label_text]
          end
        )
      end)

    {:safe, escaped_options}
  end

  def render_options(options, "radiobuttons" = _type, name) do
    escaped_options =
      options
      |> Enum.map(fn %Brs.Forms.Option{label: label, value: value} ->
        safe_to_string(
          content_tag(:label, class: "flex items-center gap-4 text-sm leading-6 text-zinc-600") do
            radio_input =
              content_tag(:input, "",
                type: "radio",
                value: value,
                name: name,
                class: "rounded-lg border-zinc-300 text-zinc-900 focus:ring-0"
              )

            label_text = Phoenix.HTML.raw(label)

            [radio_input, label_text]
          end
        )
      end)

    {:safe, escaped_options}
  end
end
