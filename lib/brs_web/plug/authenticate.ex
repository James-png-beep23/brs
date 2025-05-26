defmodule BrsWeb.Plug.Authenticate do
  use BrsWeb, :verified_routes
  import Plug.Conn
  import Phoenix.Controller
  alias Brs.Accounts
  @remember_me_cookie "_brs_web_user_remember_me"

  @doc """
  Logs the user in.
  """
  def log_in_user(conn, user, _params \\ %{}) do
    timeout = Application.get_env(:brs, :session)[:timeout] || 30
    client_ip = get_req_header(conn, "x-forwarded-for") |> req_header_or_nil()
    user_agent = get_req_header(conn, "user-agent") |> req_header_or_nil()

    {user, session_params} = params_for_session(user)

    session_params =
      Map.merge(session_params, %{
        client_ip: client_ip,
        user_agent: user_agent,
        timeout: timeout * 60
      })

    %{session_id: session_id} = Accounts.create_session!(user, session_params)

    expires_at =
      DateTime.utc_now()
      |> Timex.shift(minutes: timeout)

    conn
    |> renew_session()
    |> put_token_in_session(%{
      "session_id" => session_id,
      "expires_at" => expires_at
    })
  end

  @doc """
  Authenticates the user by looking into the session
  and remember me token.
  """
  def fetch_current_user(conn, _opts) do
    {user_session, conn} = ensure_user_session(conn)

    # TODO authenticate user using remember me token

    case user_session do
      %{"session_id" => session_id, "expires_at" => expires_at} ->
        expires_at =
          case expires_at do
            %DateTime{} -> expires_at
            _ -> DateTime.utc_now()
          end

        if DateTime.compare(DateTime.utc_now(), expires_at) == :lt do
          user = Accounts.get_user_by_session(session_id)

          case Accounts.is_not_blacklisted(user) do
            {:ok, true} ->
              conn
              |> assign(:current_user, user)
              |> assign(:current_account, fn ->
                if user do
                  Accounts.get_account_by_user_id(user.id)
                end
              end)

            {:error, _} ->
              conn
              |> assign(:current_user, nil)
              |> assign(:error, "blacklisted")
          end
        else
          conn
          |> assign(:current_user, nil)
          |> assign(:error, "session expired")
        end

      _ ->
        conn
        |> assign(:current_user, nil)
        |> assign(:error, "invalid session")
    end
  end

  @spec log_out_user(Plug.Conn.t()) :: Plug.Conn.t()
  @doc """
  Logs the user out.

  It clears all session data for safety. See renew_session.
  """
  def log_out_user(conn) do
    %{"session_id" => session_id} = get_session(conn, :session_id)
    session_id && Accounts.delete_user_session(session_id)

    if live_socket_id = get_session(conn, :live_socket_id) do
      BrsWeb.Endpoint.broadcast(live_socket_id, "disconnect", %{})
    end

    conn
    |> renew_session()
    |> delete_resp_cookie(@remember_me_cookie)
    |> redirect(to: ~p"/")
  end

  @doc """
  Used for routes that require the user to be authenticated.

  """
  def authenticated(conn, _opts) do
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> maybe_store_return_to()
        |> redirect(to: ~p"/auth/login/sso")
        |> halt()

      _user ->
        timeout = Application.get_env(:brs, :session)[:timeout] || 30
        %{"session_id" => session_id, "expires_at" => _} = get_session(conn, :session_id)

        new_expiry =
          Timex.shift(DateTime.utc_now(), minutes: timeout)

        put_session(conn, :session_id, %{
          "session_id" => session_id,
          "expires_at" => new_expiry
        })
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    put_session(conn, :redirect_to, current_path(conn))
  end

  defp maybe_store_return_to(conn), do: conn

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end

  defp ensure_user_session(conn) do
    if session = get_session(conn, :session_id) do
      {session, conn}
    else
      {nil, conn}
    end
  end

  defp req_header_or_nil(header) do
    case header do
      [value | _] ->
        value

      [] ->
        nil
    end
  end

  defp params_for_session({business_user, real_user}) do
    {business_user, %{real_user_id: real_user.id}}
  end

  defp params_for_session(user) do
    {user, %{}}
  end

  defp put_token_in_session(conn, %{"session_id" => session_id} = session) do
    conn
    |> put_session(:session_id, session)
    |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(session_id)}")
  end

  defp put_token_in_session(conn, _) do
    conn
  end
end
