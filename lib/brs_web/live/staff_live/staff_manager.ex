defmodule BrsWeb.StaffLive.StaffManager do
  alias Brs.Accounts.User
  alias Brs.Accounts.BackendUser
  alias Brs.Accounts
  use BrsWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:roles, Accounts.list_roles())}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    apply_action(socket, socket.assigns.live_action, params)
  end

  # add new staff
  defp apply_action(socket, :new, _params) do
    {:noreply,
     socket
     |> assign(:staff, nil)
     |> assign(:page_title, "Add Staff")}
  end

  # edit staff
  defp apply_action(socket, :edit, %{"id" => user_id}) do
    staff = Accounts.get_backend_user_by_user_id(user_id)
    current_registry = socket.assigns.current_registry

    user = socket.assigns[:user] || user(staff)

    if user == nil do
      {:noreply,
       socket
       |> put_flash(:error, "Failed to load staff: #{user_id}")
       |> push_navigate(to: ~p"/admin/registries/#{current_registry.slug}/staffs/new")}
    else
      changeset = Accounts.change_backend_users(staff || %BackendUser{})

      assigned_role_ids = get_assigned_role_ids(changeset)

      {:noreply,
       socket
       |> assign(:user, user)
       |> assign_form(changeset)
       |> assign(:staff, staff || %BackendUser{})
       |> assign(:assigned_role_ids, assigned_role_ids)
       |> assign(:page_title, "Edit Staff")}
    end
  end

  @impl true
  def handle_event("search_staff", %{"id_number" => id_number}, socket) do
    current_registry = socket.assigns.current_registry

    socket =
      case Accounts.get_user_by_id_number(id_number) do
        nil ->
          put_flash(socket, :error, "User not found")

        user ->
          socket
          |> assign(:user, user)
          |> push_patch(to: ~p"/admin/registries/#{current_registry.slug}/staffs/#{user.id}/edit")
      end

    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"backend_user" => staff_params}, socket) do
    changeset = Accounts.change_backend_users(socket.assigns.staff, staff_params)
    assigned_role_ids = get_assigned_role_ids(changeset)

    {:noreply,
     assign(socket, form: to_form(changeset, action: :validate))
     |> assign(:assigned_role_ids, assigned_role_ids)}
  end

  @impl true
  def handle_event("save", %{"backend_user" => staff_params}, socket) do
    create_or_update_staff(socket, staff_params)
  end

  @impl true
  def handle_event("search-roles", %{"search_role" => search_role}, socket) do
    roles = sort_roles(socket.assigns[:roles], search_role)

    {:noreply, socket |> assign(:roles, roles)}
  end

  defp create_or_update_staff(socket, staff_params) do
    user = socket.assigns[:user]
    current_registry = socket.assigns.current_registry

    attrs =
      Map.merge(
        staff_params,
        %{"user_id" => user.id, "registry_id" => current_registry.id}
      )

    staff = socket.assigns[:staff] || %BackendUser{}

    case Accounts.create_or_update_backend_user(staff, attrs) do
      {:ok, _staff} ->

        {:noreply,
         socket
         |> put_flash(:info, "Staff updated successfully")
         |> push_navigate(to: ~p"/admin/registries/#{current_registry.slug}/staffs")}

      {:error, %Ecto.Changeset{} = changeset} ->
        Brs.Helpers.print_changeset_errors(changeset)
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def get_assigned_role_ids(changeset) do
    case Ecto.Changeset.get_field(changeset, :backend_user_roles) do
      roles when is_list(roles) ->
        Enum.map(roles, & &1.role_id)

      _ ->
        []
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp user(nil), do: nil
  defp user(%User{} = user), do: user
  defp user(%BackendUser{user: user}), do: user

  defp sort_roles(nil, _search_role), do: []
  defp sort_roles(_, search_role) when search_role in [nil, ""], do: Accounts.list_roles()

  defp sort_roles(roles, search_role) do
    roles
    |> Enum.sort_by(fn role ->
      if String.starts_with?(String.downcase(role.name), search_role), do: 0, else: 1
    end)
  end
end
