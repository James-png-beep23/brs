defmodule Brs.Repo do
  alias Ecto.Multi

  use Ecto.Repo,
    otp_app: :brs,
    adapter: Ecto.Adapters.Postgres

  use Brs.AuditTrails,
    repo: __MODULE__,
    schema: Brs.AuditLog

  # Custom insert function with audit logging
  def insert_with_audit(changeset, opts \\ []) do
    Multi.new()
    |> Multi.insert(:record, changeset, opts)
    |> Multi.run(:audit_log, fn _repo, %{record: record} ->
      audit_log("insert", changeset, record.id)
    end)
    |> __MODULE__.transaction()
    |> case do
      {:ok, %{record: record}} -> {:ok, record}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  # Custom update function with audit logging
  def update_with_audit(changeset, opts \\ []) do
    Multi.new()
    |> Multi.update(:record, changeset, opts)
    |> Multi.run(:audit_log, fn _repo, %{record: record} ->
      audit_log("update", changeset, record.id)
    end)
    |> __MODULE__.transaction()
    |> case do
      {:ok, %{record: record}} -> {:ok, record}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  def delete_with_audit(struct, opts \\ []) do
    Multi.new()
    |> Multi.delete(:record, struct, opts)
    |> Multi.run(:audit_log, fn _repo, %{record: record} ->
      audit_delete(record)
    end)
    |> __MODULE__.transaction()
    |> case do
      {:ok, %{record: record}} -> {:ok, record}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end
end
