defmodule BrsWeb.SystemController do
  use BrsWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:current_tab, :admin)
    |> render(:index)
  end
end
