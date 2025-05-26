defmodule BrsWeb.Plug.LoadRegistries do
  def init(opts), do: opts

  def call(conn, _opts) do
    registries = Brs.Registries.list_enabled_registries()

    default_registry =
      Brs.Registries.get_default_registry() ||
        Brs.Registries.get_registry_by(slug: "brs")

    Plug.Conn.assign(conn, :default_registry, default_registry)
    Plug.Conn.assign(conn, :all_registries, registries)
  end
end
