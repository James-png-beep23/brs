defmodule Brs.Services do
  import Ecto.Query

  alias Brs.Repo
  alias Brs.Services.Service

  def list_services do
    Repo.all(from(p in Service, order_by: [desc: p.inserted_at]))
    |> Repo.preload([:form, :registry])
  end

  def change_service(%Service{} = service, attrs \\ %{}) do
    Service.changeset(service, attrs)
  end

  def get_service!(id), do: Repo.get!(Service, id) |> Repo.preload([:form, :registry])

  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert_with_audit()
  end

  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update_with_audit()
  end

  def services_registry_query(queryable \\ Service, registry_id) do
    from(q in queryable,
      order_by: [desc: q.inserted_at],
      where: q.registry_id == ^registry_id
    )
  end

  def preload_query(queryable \\ Service, field_or_fields) do
    from(q in queryable, preload: ^field_or_fields)
  end

  def get_services(queryable \\ Service) do
    queryable |> Repo.all()
  end

  def increment_counter(service_id, value \\ 1) do
    {1, [application_counter]} =
      from(s in Service,
        select: s.application_counter,
        where: s.id == ^service_id,
        update: [inc: [application_counter: ^value]]
      )
      |> Repo.update_all([])

    application_counter
  end
end
