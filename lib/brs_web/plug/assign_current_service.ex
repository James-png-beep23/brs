defmodule BrsWeb.Plug.AssignCurrentService do
  alias Brs.Services
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    service = Services.get_service!(conn.params["id"])

    assign(conn, :current_service, service)
    |> assign(:current_registry, service.registry)
  end
end
