defmodule BrsWeb.EntityRouter do
  defmacro frontend_routes() do
    quote do
      unquote(view_routes())
    end
  end

  defp view_routes() do
    quote do
      # Business register routes
      scope "/businesses/:business_id", BusinessRegisterLive do
        live "/services/", Business, :services
        live "/services/:service_id", Business, :view_services
        live "/details", Business, :details
        live "/annual-returns", Business, :annual_returns
        live "/manage", Business, :manage
        live "/access-control", Business, :access_control
        live "/audit-trail", Business, :audit_trail
        live "/esecretary", Business, :esecretary
        live "/employees", Business, :employees
      end
    end
  end
end
