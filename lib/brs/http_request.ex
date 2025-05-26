defmodule Brs.HTTPRequest do
  require Logger
  alias Brs.HTTPClient

  def execute(url, method, body, headers, opts \\ []) do
    method = method(method)
    enctype = enctype(opts[:enctype])
    body = process_with_enctype(body, enctype)

    headers =
      headers
      |> add_content_type_header(enctype)
      |> add_auth_header(opts)

    opts = Keyword.drop(opts, [:auth, :enctype])

    Logger.info(
      "HTTP_REQUEST #{method} to #{url} with body #{inspect(body, limit: :infinity, printable_limit: :infinity)}"
    )

    response =
      HTTPClient.adapter().request(
        method,
        url,
        body,
        headers,
        Keyword.merge(HTTPClient.options(), opts)
      )
      |> process_response()

    response
  end

  defp add_content_type_header(headers, enctype) do
    if Enum.find(headers, fn {header, _} -> String.downcase(header) == "content-type" end) do
      headers
    else
      type =
        case enctype do
          "json" -> "application/json"
          "x-www-form-urlencoded" -> "application/x-www-form-urlencoded"
          _ -> "text/xml"
        end

      [{"content-type", type} | headers]
    end
  end

  defp add_auth_header(headers, opts) do
    case opts[:auth] do
      {"basic", params} ->
        username = Map.fetch!(params, "username")
        password = Map.fetch!(params, "password")
        [{"Authorization", "Basic " <> Base.encode64("#{username}:#{password}")} | headers]

      {"bearer", token} ->
        [{"Authorization", "Bearer " <> token} | headers]

      _ ->
        headers
    end
  end

  defp process_with_enctype("", _), do: ""
  defp process_with_enctype(nil, _), do: nil

  defp process_with_enctype(body, "json") do
    # helps to trim extra spaces and new lines
    body = Brs.Helpers.json_trim_extra_commas(body)

    with {:ok, data} <- Poison.decode(body),
         {:ok, data} <- Poison.encode(data) do
      data
    else
      {:error, error} ->
        Logger.error(
          "=== Failed to decode/encode json #{inspect(body, limit: :infinity, printable_limit: :infinity)}"
        )

        raise inspect(error)
    end
  end

  defp process_with_enctype(body, enctype) when enctype in ["none", "json", "raw"], do: body

  defp process_with_enctype(body, type) when type in ["form", "form-data"] do
    {:multipart, encode_form_data(body)}
  end

  defp process_with_enctype(body, "x-www-form-urlencoded") do
    encode_form_data(body)
  end

  defp encode_form_data(body) do
    case Poison.decode(body) do
      {:ok, map} -> Plug.Conn.Query.encode(map)
      # if body is not a valid json string, assume its already a url encoded string
      _ -> Plug.Conn.Query.decode(body) |> Plug.Conn.Query.encode()
    end
  end

  defp enctype(nil), do: "raw"
  defp enctype(type), do: type

  defp method("get"), do: :get
  defp method("post"), do: :post
  defp method("put"), do: :put
  defp method("patch"), do: :patch
  defp method("delete"), do: :delete

  defp process_response({:ok, response}) do
    body =
      case Jason.decode(response.body || "") do
        {:ok, data} ->
          data

        _ ->
          # check content type and parse based on that
          parse_body(response.body)
      end

    {:ok, %{body: body, status_code: response.status_code}}
  end

  defp process_response({:error, response}) do
    {:error, response.reason}
  end

  defp parse_body(body) do
    result =
      try do
        :erlsom.simple_form(body)
      rescue
        e ->
          Logger.warning("[Brs.HTTPRequest.parse_body] xml parsing failed with #{inspect(e)}")
      catch
        e ->
          Logger.warning("[Brs.HTTPRequest.parse_body] xml parsing failed with #{inspect(e)}")
      end

    case result do
      {:ok, element, _} -> xml_to_json(element, %{})
      _ -> body
    end
  end

  defp xml_to_json({tag, _attrs, content}, accum) do
    # hack because when xmlns matches tag name the xmlns is wrapped in curly braces and set as the tag name
    # this removes the curly braces
    tag = tag |> to_string |> String.replace(~r/\{.+?\}/, "")
    Map.put(accum, to_string(tag), Enum.reduce(content, %{}, &xml_to_json/2))
  end

  defp xml_to_json(value, _accum) do
    to_string(value) |> String.trim()
  end
end
