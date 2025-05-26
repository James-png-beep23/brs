defmodule BrsWeb.Plug.RequestURI do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    current_uri = URI.parse(Phoenix.Controller.current_url(conn))
    assign(conn, :current_uri, current_uri)
  end
end
