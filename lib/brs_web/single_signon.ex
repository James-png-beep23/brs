defmodule BrsWeb.SingleSignon do
  @moduledoc """
  Provides single-signon helper functions
  """

  @doc """
  Validate the payload by checking the the signature and expiry
  """
  @spec verify_payload(Map.t()) :: :ok | {:error, String.t()}
  def verify_payload(payload) do
    with :ok <- verify_signature(payload),
         :ok <- validate_expiry(payload) do
      :ok
    end
  end

  defp verify_signature(%{"signature" => signature} = payload) do
    data = Map.drop(payload, ["signature", "entity"])

    # compute the signature and compare
    if Plug.Crypto.secure_compare(compute_signature(data), signature),
      do: :ok,
      else: {:error, "bad signature"}
  end

  def compute_signature(%{} = data) do
    :crypto.mac(:hmac, :sha256, client_secret(), Poison.encode!(data))
    |> Base.encode64()
  end

  defp validate_expiry(%{"at" => at}) do
    with {:ok, generated_at, _} <- DateTime.from_iso8601(at),
         time_diff = Timex.diff(DateTime.utc_now(), generated_at, :seconds),
         true <- time_diff < expire_after() do
      :ok
    else
      _ ->
        {:error, :expired}
    end
  end

  defp config() do
    Application.fetch_env!(:brs, __MODULE__)
  end

  defp client_secret() do
    Keyword.fetch!(config(), :client_secret)
  end

  defp expire_after() do
    # default 10 minutes
    Keyword.get(config(), :expire_after, 600)
  end

  @spec user_params_from_data(Map.t()) :: Map.t()
  def user_params_from_data(data) do
    # pull out user details
    Map.take(
      data,
      ~w(id_number account_type email mobile_number first_name last_name surname dob gender citizenship)
    )
    |> normalize_user_params()
    |> Map.put("entity", data["entity"])
  end

  def register_url(), do: url("register")

  defp url(path) do
    config()
    |> Keyword.fetch!(:base_url)
    |> URI.merge(path)
    |> to_string()
  end

  # changes the keys to match our user schema
  defp normalize_user_params(
         %{
           "id_number" => id_number,
           "account_type" => account_type,
           "email" => email,
           "mobile_number" => phone_number,
           "first_name" => first_name,
           "last_name" => last_name,
           "surname" => surname
         } = params
       ) do
    %{
      "id_number" => id_number,
      "id_type" => account_type,
      "email" => email,
      "phone_number" => phone_number,
      "first_name" => first_name,
      "last_name" => last_name,
      "surname" => surname,
      "date_of_birth" => params["dob"],
      "gender" => params["gender"],
      "nationality" => params["citizenship"] || "KE"
    }
  end
end
