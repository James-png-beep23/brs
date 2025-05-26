defmodule BrsWeb.ControllerHelpers do
  def is_authenticated?(conn) do
    not is_nil(conn.assigns.current_user)
  end
end
