defmodule BrsWeb.PageController do
  use BrsWeb, :controller

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> put_layout(html: :landing)
    |> render(:index)
  end
end
