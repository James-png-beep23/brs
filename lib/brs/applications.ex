defmodule Brs.Applications do
  import Ecto.Query, only: [from: 2]

  alias Brs.Services
  alias Brs.Repo
  alias Brs.Applications.Application

  defmodule HashId do
    @coder Hashids.new(
             alphabet: "3456789ABCDEFGHJKLMNPQRSTUVWQY",
             salt: "97yD9DBThCSxMpjmqm+xQ+9NWaFJRhdZl0edvC0aPNg=",
             min_len: 5
           )
    def encode(value) do
      Hashids.encode(@coder, value)
    end

    def decode(hash_id) do
      Hashids.decode(@coder, hash_id)
    end
  end

  def create_application(service, user_account, form_data, created_by, attrs \\ %{}) do
    do_create(service, user_account, form_data, created_by, attrs)
  end

  defp do_create(service, user_account, form_data, created_by, params) do
    application_number = generate_application_number(service)

    attrs =
      Map.merge(params, %{
        application_number: application_number,
        account_id: user_account.id,
        created_by_id: created_by.id,
        submitted_by_id: created_by.id,
        submitted_at: NaiveDateTime.utc_now(),
        service_id: service.id,
        form_id: service.form_id,
        form_data: form_data
      })

    %Application{}
    |> Application.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:error, error} -> {:error, error}
      {:ok, app} -> {:ok, app}
    end
  end

  def update(appl, params) do
    appl
    |> Application.changeset(params)
    |> Repo.update()
  end

  def get_application!(id), do: Repo.get!(Application, id) |> preload_creator()

  def list_applications(account) do
    Application.account_applications_query(account)
    |> Application.join_service_query()
    |> Repo.all()
    |> preload_creator()
  end

  def list_applications_by_registry(account, registry) do
    from(appl in Application,
      join: s in assoc(appl, :service),
      where: appl.account_id == ^account.id and s.registry_id == ^registry.id,
      order_by: [asc: :id],
      preload: [service: s]
    )
    |> Repo.all()
    |> preload_creator()
  end

  def preload_service(application) do
    Repo.preload(application, service: [:registry, :form])
  end

  def preload_user(application) do
    Repo.preload(application, :user)
  end

  def preload_creator(application) do
    Repo.preload(application, [:created_by, :submitted_by])
  end

  def preload_form(application) do
    Repo.preload(application, :form)
  end

  def application_search_by_registry(registry_id, term) when is_binary(term) do
    appl_number_query(Application, term, registry_id)
    |> Repo.all(timeout: 30000)
  end

  def search(schema, term) do
    schema
    |> search_query(term)
    |> Repo.all(timeout: 30000)
    |> preload(schema)
  end

  defp search_query(queryable, term) when is_binary(term) do
    case queryable do
      Application -> appl_number_query(queryable, term)
      _ -> search_query(queryable, term)
    end
  end

  defp search_query(queryable, term) when term in [nil, ""], do: queryable

  defp preload(results, Brs.Applications.Application) do
    results
    |> preload_service()
    |> preload_creator()
  end

  def appl_number_query(queryable, application_number, registry_id \\ nil)

  def appl_number_query(queryable, application_number, nil)
      when application_number in ["", nil] do
    queryable
  end

  def appl_number_query(queryable, application_number, registry_id)
      when application_number in ["", nil] and not is_nil(registry_id) do
    from(appl in queryable,
      join: s in assoc(appl, :service),
      where: s.registry_id == ^registry_id,
      order_by: [asc: :id],
      preload: [service: s]
    )
  end

  def appl_number_query(queryable, application_number, nil) do
    application_number =
      application_number
      |> String.trim()
      |> String.upcase()

    from(n in queryable,
      where: n.application_number == ^application_number,
      order_by: [asc: :id]
    )
  end

  def appl_number_query(queryable, application_number, registry_id) do
    application_number =
      application_number
      |> String.trim()
      |> String.upcase()

    from(appl in queryable,
      join: s in assoc(appl, :service),
      where: appl.application_number == ^application_number and s.registry_id == ^registry_id,
      order_by: [asc: :id],
      preload: [service: s]
    )
  end

  defp generate_application_number(service) do
    application_counter = Services.increment_counter(service.id)

    [
      get_prefix(service.prefix),
      HashId.encode([service.id, application_counter])
    ]
    |> Enum.join("-")
  end

  defp get_prefix(prefix) do
    String.replace(prefix, ~r/\r?\n|\r|\s/, "")
    |> String.trim()
    |> String.upcase()
  end
end
