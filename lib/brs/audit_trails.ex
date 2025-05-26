defmodule Brs.AuditTrails do
  @moduledoc """
  To use AuditTrails in your module:-

    `use Brs.AuditTrails,
      repo: Brs.Repo,
      schema: Brs.AuditLog`

  """
  import Ecto.Query

  defmacro __using__(opts) do
    quote do
      @repo unquote(opts[:repo])
      @schema unquote(opts[:schema])
      def audit_log(action, changeset, record_id) do
        Brs.AuditTrails.do_audit(
          @repo,
          @schema,
          action,
          changeset,
          record_id
        )
      end

      def list_audits(filters \\ %{}) do
        Brs.AuditTrails.list_audits(@repo, @schema, filters)
      end

      def audit_delete(record) do
        Brs.AuditTrails.log_delete(@repo, @schema, record)
      end
    end
  end

  def do_audit(_, _, _, %Ecto.Changeset{changes: changes} = _changeset, _)
      when map_size(changes) == 0 do
    :ok
  end

  def do_audit(repo, schema, action, changeset, record_id) do
    %{data: data, changes: changes} = changeset
    resource = data.__struct__.__schema__(:source)

    schema
    |> create_audit_changeset(action, resource, record_id, changes)
    |> insert_audit_changeset(repo)
  end

  @doc """
  Retrive audits
  """

  def list_audits(repo, schema, filters) do
    from(a in schema,
      where:
        ^Enum.reduce(filters, true, fn {key, value}, acc ->
          dynamic([a], field(a, ^key) == ^value and ^acc)
        end),
      order_by: [desc: a.inserted_at]
    )
    |> repo.all()
  end

  # Function to log delete action
  def log_delete(repo, schema, record) do
    resource = record.__struct__.__schema__(:source)

    schema
    |> create_audit_changeset("delete", resource, record.id)
    |> insert_audit_changeset(repo)
  end

  # create an audit changeset
  defp create_audit_changeset(
         schema,
         action,
         resource,
         record_id,
         changes \\ %{}
       ) do
    user_id = Process.get(:audit_log_user_id)

    schema
    |> struct()
    |> schema.changeset(%{
      action: action,
      resource: resource,
      record_id: record_id,
      changes: changes,
      user_id: user_id
    })
  end

  # insert an audit
  defp insert_audit_changeset(changeset, repo) do
    case changeset.valid? do
      true ->
        case repo.insert!(changeset) do
          %{} = record -> {:ok, record}
          {:error, error} -> {:error, error}
        end

      false ->
        Brs.Helpers.print_changeset_errors(changeset)
        {:error, changeset}
    end
  end
end
