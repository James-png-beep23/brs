defmodule BrsWeb.SingleSignon.OAuth2 do
  @moduledoc """
  OAuth2 client logic for SingleSignOn.
  """

  use OAuth2.Strategy

  def client do
    config = Application.get_env(:brs, BrsWeb.SingleSignon)

    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: config[:client_id],
      client_secret: config[:client_secret],
      redirect_uri: config[:redirect_uri],
      site: config[:base_url],
      authorize_url: config[:authorize_url],
      token_url: config[:token_url]
    )
  end

  def authorize_url!() do
    verifier = generate_code_verifier()
    code_challenge = generate_code_challenge(verifier)

    state = generate_oauth2_state(verifier)

    OAuth2.Client.authorize_url!(client(),
      response_type: "code",
      scope: "openid",
      state: state,
      code_challenge: code_challenge,
      code_challenge_method: "S256"
    )
  end

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token!(verifier, params \\ [], headers \\ [], opts \\ []) do
    config = Application.get_env(:brs, BrsWeb.SingleSignon)
    oauth2_client = config[:oauth2_client]

    oauth2_client.get_token!(
      client(),
      Keyword.merge(params,
        client_id: config[:client_id],
        client_secret: config[:client_secret],
        grant_type: "authorization_code",
        redirect_uri: config[:redirect_uri],
        code_verifier: verifier
      ),
      headers,
      opts
    )
  end

  def get_token(client, params, headers) do
    client
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  def fetch_user_info(access_token) do
    config = Application.get_env(:brs, BrsWeb.SingleSignon)

    url =
      URI.merge(config[:base_url], config[:user_info_url] || "")
      |> URI.append_query("access_token=#{access_token}")
      |> to_string()

    Brs.HTTPRequest.execute(url, "get", "", [], [])
    |> case do
      {:ok, %{body: body, status_code: _status}} -> {:ok, body}
      {:error, message} -> {:error, message}
    end
  end

  defp generate_code_verifier(len \\ 128) when len >= 43 and len <= 128 do
    :crypto.strong_rand_bytes(len)
    |> Base.encode64(padding: false)
    |> String.slice(0, len)
  end

  defp generate_code_challenge(verifier) do
    :crypto.hash(:sha256, verifier)
    |> Base.url_encode64(padding: false)
  end

  defp generate_oauth2_state(verifier) do
    rand_bytes = :crypto.strong_rand_bytes(16)

    plain_oauth2_state =
      rand_bytes
      |> Base.encode16(case: :lower)

    Cachex.put(:oauth2_state_verifier, plain_oauth2_state, verifier)

    plain_oauth2_state
  end

  def get_stored_verifier(state) do
    case Cachex.take(:oauth2_state_verifier, state) do
      {:ok, nil} ->
        {:error, :verifier_not_found}

      {:ok, value} ->
        {:ok, value}

      _ ->
        {:error, :verifier_not_found}
    end
  end
end
