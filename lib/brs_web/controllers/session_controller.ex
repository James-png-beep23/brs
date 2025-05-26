defmodule BrsWeb.SessionController do
  use BrsWeb, :controller

  require Logger

  alias BrsWeb.SingleSignon
  alias BrsWeb.SingleSignon.OAuth2
  alias Brs.Accounts
  alias BrsWeb.Plug.Authenticate

  plug(:redirect_if_already_logged_in when action in [:index])

  def login_sso(conn, _) do
    oauth2_redirect_url = OAuth2.authorize_url!()
    redirect(conn, external: oauth2_redirect_url)
  end

  @spec login_sso_callback(Plug.Conn.t(), nil | maybe_improper_list() | map()) :: Plug.Conn.t()
  def login_sso_callback(conn, %{"code" => authorization_code, "state" => state}) do
    with {:ok, verifier} <- OAuth2.get_stored_verifier(state),
         %{token: %{access_token: token}} <-
           OAuth2.get_token!(verifier, code: authorization_code),
         {:ok, map} <- Jason.decode(token),
         access_token <- Map.get(map, "access_token"),
         {:ok, user_params} <- OAuth2.fetch_user_info(access_token),
         {:ok, user} <- Accounts.create_or_update_with_entity(user_params) do
      do_login_user(conn, user)
    else
      _ ->
        put_flash(conn, :error, "Something went wrong")
        |> redirect(redirect_option(Routes.page_path(conn, :index)))
    end
  end

  def login_sso_callback(conn, params) do
    conn
    |> put_flash(:error, params["error_description"])
    |> redirect(redirect_option(Routes.page_path(conn, :index)))
  end

  def register_sso(conn, _) do
    conn
    |> redirect(external: SingleSignon.register_url())
  end

  def logout(conn, _) do
    conn
    |> put_flash(:info, "Successfully logged out.")
    |> Authenticate.log_out_user()
  end

  defp do_login_user(conn, user) do
    with {:ok, true} <- Accounts.is_not_blacklisted(user) do
      conn
      |> clear_session()
      |> configure_session(renew: true)
      |> Authenticate.log_in_user(user)
      |> redirect(redirect_option(redirect_path(conn)))
    else
      {:error, "blacklisted"} ->
        redirect(conn, to: "/blacklisted")

      {:error, _, errors, _} ->
        Logger.info("=========== #{inspect(errors)} ============")

        redirect(conn, to: "/")

      error ->
        Logger.info("=========== #{inspect(error)} ============")

        conn
        |> put_flash(:error, "Something went wrong, please try again")
        |> redirect(to: "/")
    end
  end

  defp redirect_path(conn) do
    redirect_to = conn.query_params["redirect_to"] || get_session(conn, "redirect_to")

    redirect_to =
      if is_index_page(redirect_to), do:  ~p"/registries/brs/dashboard", else: redirect_to

    if redirect_to && redirect_to != "" do
      redirect_to
    else
      ~p"/registries/brs/dashboard"
    end
  end

  defp redirect_option(url_or_path) do
    case URI.parse(url_or_path) do
      %URI{host: nil} -> [to: url_or_path]
      _ -> [external: url_or_path]
    end
  end

  defp is_index_page(path) do
    path == BrsWeb.Router.Helpers.page_url(BrsWeb.Endpoint, :index) or
      path == BrsWeb.Router.Helpers.page_path(BrsWeb.Endpoint, :index)
  end

  defp redirect_if_already_logged_in(conn, _) do
    if conn.assigns[:current_user] do
      redirect(conn, to:  ~p"/registries/brs/dashboard")
    else
      conn
    end
  end
end
