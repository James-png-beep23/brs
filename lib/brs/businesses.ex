defmodule Brs.Businesses do
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset

  alias Brs.Repo

  alias Brs.Businesses.{
    ShareCategory,
    BusinessType,
    BusinessOwner,
    Business,
    NameSearch,
    BusinessOwnerType
  }

  alias Brs.Accounts.Account

  def create_business(params) do
    changeset = Business.changeset(%Business{}, params)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:business, changeset)
      |> Ecto.Multi.run(:accounts, fn _repo, %{business: business} ->
        insert_business_account(business)
      end)
      |> Ecto.Multi.run(:owners, &insert_business_owners(&1, &2, params))
      |> Ecto.Multi.run(:share_categories, &insert_share_categories(&1, &2, params))
      |> Repo.transaction(timeout: :infinity)

    case result do
      {:ok, %{business: business}} -> {:ok, business}
      {:error, _, changeset, _} -> {:error, changeset}
    end
  end

  defp insert_business_account(business) do
    %Account{}
    |> Account.changeset(%{business_id: business.id})
    |> Repo.insert()
  end

  def name_search(params) do
    NameSearch
    |> name_search_query(params["q"])
    |> Repo.all(timeout: 30000)
    |> preload(NameSearch)
  end

  def business_search(params) do
    Business
    |> business_search_query(params["q"])
    |> Repo.all(timeout: 30000)
    |> preload(Business)
  end

  defp preload(results, Brs.Businesses.Business) do
    Repo.preload(results, [:business_type])
  end

  defp preload(results, Brs.Businesses.NameSearch) do
    Repo.preload(results, [:business_type, :business])
  end

  defp business_search_query(queryable, term) when is_binary(term) do
    do_search(queryable, "name", term)
    |> Ecto.Query.or_where([q], fragment("lower(?) = lower(?)", q.registration_number, ^term))
  end

  defp name_search_query(queryable, term) when is_binary(term) do
    do_search(queryable, "name", term)
  end

  defp do_search(queryable, "name", value) do
    from(q in queryable,
      where:
        fragment("to_tsvector('english', ?) @@ plainto_tsquery('english', ?)", q.name, ^value) or
          fragment("to_tsvector('simple', ?) @@ plainto_tsquery('simple', ?)", q.name, ^value),
      order_by: [
        desc:
          fragment(
            """
            ts_rank(to_tsvector('simple', ?), plainto_tsquery('simple', ?)) + ts_rank(to_tsvector('english', ?), plainto_tsquery('english', ?))
            """,
            q.name,
            ^value,
            q.name,
            ^value
          )
      ]
    )
  end

  defp do_search(queryable, field, value) do
    field = String.to_existing_atom(field)
    from(q in queryable, where: field(q, ^field) == ^value)
  end

  defp insert_business_owners(repo, %{business: business}, params) do
    owners_params = Map.get(params, "owners") || []

    owners_changesets =
      Enum.map(owners_params, fn owner_params ->
        owner_params = Map.put(owner_params, "business_id", business.id)
        BusinessOwner.changeset(%BusinessOwner{}, owner_params)
      end)

    case Enum.find(owners_changesets, &(&1.valid? == false)) do
      nil ->
        Enum.each(owners_changesets, &repo.insert!(&1))
        {:ok, :inserted}

      invalid_changeset ->
        {:error, invalid_changeset}
    end
  end

  defp insert_share_categories(repo, %{business: business}, params) do
    if BusinessType.has_shareholding?(business.business_type_id) do
      share_categories_params = Map.get(params, "share_categories") || []

      share_categories_changesets =
        Enum.map(share_categories_params, fn share_category_params ->
          share_category_params = Map.put(share_category_params, "business_id", business.id)
          ShareCategory.changeset(%ShareCategory{}, share_category_params)
        end)

      case Enum.find(share_categories_changesets, &(&1.valid? == false)) do
        nil ->
          Enum.each(share_categories_changesets, &repo.insert!(&1))
          {:ok, :inserted}

        invalid_changeset ->
          {:error, invalid_changeset}
      end
    else
      {:ok, nil}
    end
  end

  def get(id) do
    business =
      from(b in Business,
        where: b.id == ^id,
        join: t in assoc(b, :business_type),
        left_join: sc in assoc(b, :share_categories),
        left_join: o in assoc(b, :owners),
        preload: [
          business_type: t,
          share_categories: sc,
          owners:
            {o,
             [
               :business_owner_type
             ]}
        ]
      )
      |> Repo.one()

    business
  end

  def change_business_owner_type(%BusinessOwnerType{} = business_owner_type, attrs \\ %{}) do
    BusinessOwnerType.changeset(business_owner_type, attrs)
  end

  def list_business_owner_types() do
    Repo.all(BusinessOwnerType)
  end

  def get_business_owner_type(id), do: Repo.get(BusinessOwnerType, id)

  def get_business_owner_type_by(fields), do: Repo.get_by(BusinessOwnerType, fields)

  def create_business_owner_type(attrs \\ %{}) do
    %BusinessOwnerType{}
    |> BusinessOwnerType.changeset(attrs)
    |> Repo.insert()
  end

  def update_business_owner_type(%BusinessOwnerType{} = business_owner_type, attrs) do
    business_owner_type
    |> BusinessOwnerType.changeset(attrs)
    |> Repo.update()
  end

  def delete_business_owner_type(business_owner_type) do
    Repo.delete(business_owner_type)
  end

  def change_business_type(%BusinessType{} = business_type, attrs \\ %{}) do
    BusinessType.changeset(business_type, attrs)
  end

  def change_business_type_and_owner_types(%BusinessType{} = business_type, params \\ %{}) do
    business_owner_type_ids =
      case Map.get(params, "business_owner_type_ids") do
        nil -> []
        ids -> ids
      end

    change_business_type(business_type, params)
    |> put_change(:business_owner_type_ids, business_owner_type_ids)
  end

  def list_business_types() do
    Repo.all(BusinessType)
  end

  def get_business_type(id) do
    Repo.get(BusinessType, id)
    |> preload_owner_types()
    |> with_owner_types_list()
  end

  def get_business_type_by(fields), do: Repo.get_by(BusinessType, fields)

  def create_business_type(attrs \\ %{}) do
    %BusinessType{}
    |> BusinessType.changeset(attrs)
    |> Repo.insert()
  end

  def update_business_type(%BusinessType{} = business_type, attrs) do
    business_type
    |> BusinessType.changeset(attrs)
    |> Repo.update()
  end

  def delete_business_type(business_type) do
    Repo.delete(business_type)
  end

  def preload_owner_types(%BusinessType{} = business_type) do
    Repo.preload(business_type, :owner_types)
  end

  def with_owner_types_list(business_type) do
    owner_types =
      business_type.owner_types
      |> Enum.map(& &1.id)

    %BusinessType{business_type | business_owner_type_ids: owner_types}
  end
end
