defmodule BrsWeb.InitAssigns do
  @moduledoc """
  assigns from all Liveviews
  """
  use Phoenix.Component
  import Phoenix.LiveView
  alias Brs.Accounts.User
  alias Brs.Applications
  alias Brs.Applications.Application, as: Appl
  alias Brs.Services
  alias Brs.Accounts

  def on_mount(:current_user, _params, session, socket) do
    session_data = Map.get(session, "session_id")

    with %{"session_id" => session_id} <- session_data do
      timeout = Application.get_env(:brs, :session)[:timeout] || 30

      new_expiry =
        DateTime.utc_now()
        |> Timex.shift(minutes: timeout)

      user = session_id && Accounts.get_user_by_session(session_id)

      socket =
        socket
        |> assign_new(:current_user, fn -> user end)
        |> assign_new(:current_account, fn -> user && Accounts.get_account_by_user_id(user.id) end)
        |> assign(:session_id, %{
          "session_id" => session_id,
          "expires_at" => new_expiry
        })

      {:cont, socket}
    else
      _ -> {:cont, socket}
    end
  end

  def on_mount(:load_registries, _params, _session, socket) do
    registries = Brs.Registries.list_enabled_registries()

    default_registry =
      Brs.Registries.get_default_registry() ||
        Brs.Registries.get_registry_by(slug: "brs")

    {:cont,
     assign(socket,
       default_registry: default_registry,
       all_registries: registries
     )}
  end

  def on_mount(:request_uri, _params, _session, socket),
    do:
      {:cont,
       Phoenix.LiveView.attach_hook(
         socket,
         :save_request_path,
         :handle_params,
         &save_request_path/3
       )}

  def on_mount(:current_registry, params, _session, socket) do
    slug = Map.get(params, "slug", "brs")

    default_registry =
      Enum.find(socket.assigns.all_registries, fn registry -> registry.slug == slug end)

    current_backend_user = current_backend_user(socket, default_registry)

    {:cont,
     socket
     |> assign(:current_registry, default_registry)
     |> assign(:current_backend_user, current_backend_user)
     |> attach_hook(
       :switch_registry,
       :handle_event,
       &switch_registry/3
     )}
  end

  def on_mount(:current_business, params, _session, socket) do
    business_id = params["business_id"]
    {:cont, socket |> assign(:current_business, business_id)}
  end

  def on_mount(:current_service, %{"id" => service_id}, _session, socket) do
    service = Services.get_service!(service_id)

    {:cont,
     socket |> assign(:current_service, service) |> assign(:current_registry, service.registry)}
  end

  def on_mount(:current_application, %{"id" => application_id}, _session, socket) do
    %Appl{service: service} =
      application =
      Applications.get_application!(application_id)
      |> Applications.preload_service()

    {:cont,
     socket
     |> assign(:current_application, application)
     |> assign(:current_service, service)
     |> assign(:current_registry, service.registry)}
  end

  def on_mount(:audit_log_user, _, _, socket) do
    maybe_put_user_id(socket.assigns[:current_user])
    {:cont, socket}
  end

  # Handle event to switch the active registry
  defp switch_registry("switch_registry", %{"slug" => slug, "uri" => uri}, socket) do
    current_registry =
      Enum.find(socket.assigns.all_registries, fn registry -> registry.slug == slug end)

    current_backend_user = current_backend_user(socket, current_registry)

    {:cont,
     socket
     |> assign(:current_registry, current_registry)
     |> assign(:current_backend_user, current_backend_user)
     |> redirect(to: uri)}
  end

  defp switch_registry(_, _, socket) do
    {:cont, socket}
  end

  defp current_backend_user(socket, current_registry) do
    case current_registry do
      nil ->
        nil

      registry ->
        Enum.find(socket.assigns.current_user.backend_users, fn backend_user ->
          backend_user.registry_id == registry.id
        end)
    end
  end

  defp save_request_path(_params, url, socket) do
    {:cont, assign(socket, :current_uri, URI.parse(url))}
  end

  def common_hooks do
    [
      {BrsWeb.InitAssigns, :current_user},
      {BrsWeb.InitAssigns, :request_uri},
      {BrsWeb.InitAssigns, :load_registries},
      {BrsWeb.InitAssigns, :current_registry},
      {BrsWeb.InitAssigns, :current_business}
    ]
  end

  def service_hooks do
    common_hooks() ++ [{BrsWeb.InitAssigns, :current_service}]
  end

  def application_hooks do
    common_hooks() ++ [{BrsWeb.InitAssigns, :current_application}]
  end

  defp maybe_put_user_id(%User{id: user_id}),
    do: Process.put(:audit_log_user_id, user_id)

  defp maybe_put_user_id(_), do: :ok
end
