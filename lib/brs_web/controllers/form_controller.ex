defmodule BrsWeb.FormController do
  use BrsWeb, :controller

  alias Brs.Repo
  alias Brs.Forms
  alias Brs.Forms.Form
  plug BrsWeb.Plug.AuditLogUser

  def index(conn, _params) do
    forms = Repo.all(Form)

    render(conn, "index.html", forms: forms)
  end

  def delete(conn, %{"id" => form_id}) do
    form = Repo.get!(Form, form_id)

    {status, message} =
      case Forms.delete_form(form) do
        {:ok, _} ->
          {:info, "Form deleted successfully"}

        {:error, _changeset} ->
          {:error, "Something went wrong"}
      end

    conn
    |> put_flash(status, message)
    |> redirect(to: "/system/forms")
  end
end
