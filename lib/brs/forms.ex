defmodule Brs.Forms do
  alias Brs.Repo
  alias Brs.Forms.{Form, Page, Field}
  import Ecto.Query, only: [from: 2]

  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert()
  end

  def update_form(%Form{} = form, attrs) do
    form
    |> Form.changeset(attrs)
    |> Repo.update()
  end

  def delete_form(%Form{} = form) do
    Repo.delete_with_audit(form)
  end

  def change_form(form, attrs \\ %{}) do
    Form.changeset(form, attrs)
  end

  def change_form_page(form_page, attrs \\ %{}) do
    Page.changeset(form_page, attrs)
  end

  def change_form_field(form_field, attrs \\ %{}) do
    Field.changeset(form_field, attrs)
  end

  def change_dynamic_form(schema, attrs \\ %{})

  def change_dynamic_form(schema, attrs) do
    Brs.Form.create_changeset(schema.pages, attrs)
  end

  def change_schema_page(form_page, attrs \\ %{})

  def change_schema_page(form_page, attrs) when not is_nil(form_page) do
    Brs.Form.change_form_page(form_page, attrs)
  end

  def change_schema_page(_, _), do: nil

  def get_forms_by_type(type) do
    Repo.all(from f in Form, where: f.type == ^type)
  end
end
