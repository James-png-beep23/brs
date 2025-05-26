defmodule Brs.Accounts do
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset
  import Ecto.Query

  alias Brs.Accounts
  alias Brs.Repo
  alias Brs.Accounts.{User, Session, Account, Role, Permission, BackendUser}
  alias BrsWeb.SingleSignon

  def get_account(id), do: Repo.get(Account, id) |> Repo.preload([:business, user: :id_type])

  @doc """
  Gets users list

  """
  def list_users do
    Repo.all(User)
  end

  def create_or_update_user(params) do
    %User{}
    |> User.changeset(params)
    |> unique_constraint(:email)
    |> Repo.insert(
      on_conflict:
        {:replace_all_except, [:id, :otp_type, :signature, :enable_developer_settings]},
      conflict_target: {:unsafe_fragment, "(id_number, id_type_id)"},
      returning: true
    )
  end

  def create_session!(user, params) do
    session_id = :crypto.strong_rand_bytes(12) |> Base.encode64()

    %Session{}
    |> change(user_id: user.id, session_id: session_id)
    |> Session.changeset(params)
    |> Repo.insert!()
  end

  def get_user_by_id_number(id_number) when not is_nil(id_number) do
    id_number_query(id_number)
    |> Repo.one()
  end

  def get_user_by_id_number(_), do: nil

  # user params from sso login
  def is_not_blacklisted(%{"id_number" => id_number, "id_type_id" => id_type}) do
    id_number_and_type_query(%{id_number: id_number, id_type: id_type})
    |> Repo.one()
    |> do_is_not_blacklisted
  end

  # when user is already in database
  def is_not_blacklisted(user), do: do_is_not_blacklisted(user)

  def create_or_update_with_entity(params) do
    {:ok, id_type_id} = get_or_create_id_type(params)

    params =
      params
      |> SingleSignon.user_params_from_data()
      |> Map.merge(%{"id_type_id" => id_type_id})

    result =
      Ecto.Multi.new()
      # always create_or_update the user
      |> Ecto.Multi.run(:user, fn _repo, _ ->
        create_or_update_user(params)
      end)
      |> Ecto.Multi.run(:accounts, fn _repo, %{user: user} -> create_user_account(user) end)
      |> Ecto.Multi.run(:business_user, fn _repo, _ ->
        case params do
          %{"entity" => %{} = entity_params} ->
            # insert business user
            entity_params
            |> Map.put("first_name", entity_params["name"])
            |> create_or_update_user()

          _ ->
            {:ok, nil}
        end
      end)
      |> Repo.transaction()

    case result do
      {:ok, %{user: user, business_user: nil}} -> {:ok, user}
      {:ok, %{user: user, business_user: %{} = business_user}} -> {:ok, {business_user, user}}
      error -> error
    end
  end

  defp do_is_not_blacklisted(nil), do: {:ok, true}

  # when a business user and real user exists
  defp do_is_not_blacklisted({user, _real_user}), do: do_is_not_blacklisted(user)

  defp do_is_not_blacklisted(%{id: user_id}) do
    blacklist = Brs.Blacklist.get_active_by_user_id(user_id)

    if is_nil(blacklist),
      do: {:ok, true},
      else: {:error, "blacklisted"}
  end

  defp id_number_and_type_query(queryable \\ User, %{
         id_number: id_number,
         id_type: id_type
       }) do
    id_number = String.trim(id_number)

    from(u in queryable,
      where: fragment("lower(?) = lower(?)", u.id_number, ^id_number) and u.id_type_id == ^id_type
    )
  end

  defp id_number_query(queryable \\ User, id_number) do
    id_number = String.trim(id_number)

    from(u in queryable,
      where: fragment("lower(?) = lower(?)", u.id_number, ^id_number)
    )
  end

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions do
    Repo.all(Session)
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Gets the user with the given signed token.
  """

  def get_user_by_session(session_id) do
    now = NaiveDateTime.utc_now()

    query =
      from s in Session,
        join: user in assoc(s, :user),
        where: s.session_id == ^session_id and s.expires_at > ^now,
        select: user

    Repo.one(query)
    |> Repo.preload(backend_users: [roles: :permissions, registry: []])
  end

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_user_session(session_id) do
    query = from Session, where: [session_id: ^session_id]
    Repo.delete_all(query)
    :ok
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end

  alias Brs.Accounts.IDType

  @doc """
  Find or create
  """
  def get_or_create_id_type(%{"account_type" => id_type} = _params) do
    case get_id_type(id_type) do
      nil ->
        create_id_type(%{slug: id_type, label: Phoenix.Naming.humanize(id_type)})

      id_type_id ->
        {:ok, id_type_id}
    end
  end

  @doc """
  Get  single ID Type
  """

  def get_id_type(id_type) do
    query =
      from t in IDType,
        where: t.slug == ^id_type,
        select: t.id

    Repo.one(query)
  end

  @doc """
  Create id types
  """
  def create_id_type(attrs \\ %{}) do
    %IDType{}
    |> IDType.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, id_type} -> {:ok, id_type.id}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def get_account_by_user_id(user_id) when not is_nil(user_id) do
    Repo.one(
      from(
        ac in Accounts.Account,
        where: ac.user_id == ^user_id
      )
    )
  end

  def get_account_by_user_id(nil), do: nil

  def create_user_account(user) do
    case get_account_by_user_id(user.id) do
      %Account{} -> {:ok, user}
      _ -> create_account(%{"user_id" => user.id})
    end
  end

  defp create_account(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def get_role(id), do: Repo.get!(Role, id)

  def list_roles() do
    Repo.all(Role)
  end

  def get_roles_by_registry(registry_id) do
    from(q in Role, where: q.registry_id == ^registry_id)
    |> Repo.all()
  end

  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def preload_permissions(%Role{} = role) do
    Repo.preload(role, :permissions)
  end

  def preload_backend_users(%Role{} = role) do
    Repo.preload(role, backend_users: [user: :id_type])
  end

  def get_permission(id), do: Repo.get!(Permission, id)

  def change_permission(%Permission{} = permission, attrs \\ %{}) do
    Permission.changeset(permission, attrs)
  end

  def update_permission(%Permission{} = permission, attrs) do
    permission
    |> Permission.changeset(attrs)
    |> Repo.update()
  end

  def preload_roles(%Permission{} = permission) do
    Repo.preload(permission, roles: [backend_users: [user: :id_type]])
  end

  def client_account_search(id_type, term) when is_binary(term) do
    client_account_search_query(id_type, term)
    |> Repo.all(timeout: 30000)
    |> Repo.preload([:business, user: :id_type])
  end

  def client_account_search_query("business" = _id_type, term) when is_binary(term) do
    from(acc in Account,
      join: b in assoc(acc, :business),
      where:
        fragment(
          "to_tsvector('simple', name || ' ') @@ plainto_tsquery('simple', ?)",
          ^term
        ),
      or_where: b.registration_number == ^term
    )
  end

  def client_account_search_query(id_type, term) when is_binary(term) do
    from(acc in Account,
      join: u in assoc(acc, :user),
      join: id in assoc(u, :id_type),
      where:
        id.slug == ^id_type and
          fragment(
            "to_tsvector('simple', coalesce(first_name, ' ') || ' ' || coalesce(last_name, ' ') || ' ' || coalesce(surname, ' ')) @@ plainto_tsquery('simple', ?)",
            ^term
          ),
      or_where: u.id_number == ^term
    )
  end

  def role_backend_users_search_query(role_id, term) when is_binary(term) do
    from(bu in BackendUser,
      join: u in assoc(bu, :user),
      join: bur in assoc(bu, :backend_user_roles),
      where:
        bur.role_id == ^role_id and
          fragment(
            "to_tsvector('simple', id_number || ' ' || first_name || ' ' || last_name || ' ' || coalesce(surname, ' ')) @@ plainto_tsquery('simple', ?)",
            ^term
          )
    )
  end

  def permission_backend_users_search_query(permission_key, term) when is_binary(term) do
    from(bu in BackendUser,
      join: u in assoc(bu, :user),
      join: r in assoc(bu, :roles),
      join: p in assoc(r, :permissions),
      where:
        p.key == ^permission_key and
          fragment(
            "to_tsvector('simple', id_number || ' ' || first_name || ' ' || last_name || ' ' || coalesce(surname, ' ')) @@ plainto_tsquery('simple', ?)",
            ^term
          )
    )
  end

  @doc """
  Backend Users
  """

  def list_backend_users() do
    Repo.all(BackendUser)
    |> Repo.preload([:user, :roles])
  end

  def list_backend_users_by_registry(registry_id) do
    BackendUser
    |> where([u], u.registry_id == ^registry_id)
    |> Repo.all()
    |> Repo.preload([:user, :roles])
  end

  def change_backend_users(struct, attrs \\ %{}) do
    struct
    |> BackendUser.changeset(attrs)
  end

  def create_or_update_backend_user(struct, params) do
    struct
    |> BackendUser.changeset(params)
    |> Repo.insert_or_update()
  end

  def get_backend_user_by_user_id(user_id) do
    Repo.get_by(BackendUser, user_id: user_id)
    |> Repo.preload([:user, :roles, backend_user_roles: [:role]])
  end

  def staff_search(registry_id, params) do
    params["filter_by"]
    |> staff_search_query(params["q"])
    |> by_registry_id_query(registry_id)
    |> Repo.all(timeout: 30000)
    |> Repo.preload([:user, :roles])
  end

  defp staff_search_query("name", term) do
    from(q in BackendUser,
      join: u in assoc(q, :user),
      where:
        fragment(
          "to_tsvector('simple', lower(first_name) || ' ' || lower(last_name) || ' ' || coalesce(surname, ' ')) @@ plainto_tsquery('simple', ?)",
          ^"%#{String.downcase(term)}%"
        )
    )
  end

  defp staff_search_query("id_number", term) do
    from(q in BackendUser,
      join: u in assoc(q, :user),
      where: u.id_number == ^term
    )
  end

  defp staff_search_query("phone_number", term) do
    from(q in BackendUser,
      join: u in assoc(q, :user),
      where: u.phone_number == ^term
    )
  end

  defp staff_search_query("email", term) do
    from(q in BackendUser,
      join: u in assoc(q, :user),
      where: u.email == ^term
    )
  end

  defp staff_search_query(_, _), do: BackendUser

  def by_registry_id_query(queryable, registry_id) do
    from(q in queryable, where: q.registry_id == ^registry_id)
  end
end
