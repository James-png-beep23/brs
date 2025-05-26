defmodule BrsWeb.Plug.AuditLogUser do
  alias Brs.Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    maybe_put_user_id(conn.assigns[:current_user])
    conn
  end

  defp maybe_put_user_id(%User{id: user_id}),
    do: Process.put(:audit_log_user_id, user_id)

  defp maybe_put_user_id(_), do: :ok
end
