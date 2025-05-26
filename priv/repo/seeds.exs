# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Brs.Repo.insert!(%Brs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Brs.Repo.Seeds do
  use ExMachina.Ecto, repo: Brs.Repo

  alias Brs.Repo

  alias Brs.Registries.Registry
  alias Brs.Businesses.{
    BusinessOwner,
    Business,
    BusinessOwnerType,
    BusinessType,
    ShareCategory,
    NameSearch
  }

  @business_types %{
    "private_limited" =>
      {"PVT", ["director", "shareholder", "secretary", "director_shareholder"]},
    "public_limited" => {"PLC", ["director", "shareholder", "secretary", "director_shareholder"]},
    "sole_proprietorship" => {"SP", ["proprietor"]},
    "limited_liability_partnership" => {"LLP", ["partner", "manager"]},
    "limited_by_guarantee" => {"CLG", ["director", "member"]}
  }

  def run(env) when env in [:dev, :test] do
    delete_all()

    %{}
    |> seed(:business_types)
    |> seed(:businesses)
    |> seed(:share_categories)
    |> seed(:business_owner_types)
    |> seed(:business_owners)
    |> seed(:name_search)
  end

  defp delete_all() do
    Repo.delete_all(NameSearch)
    Repo.delete_all(BusinessOwner)
    Repo.delete_all(ShareCategory)
    Repo.delete_all(Business)
    Repo.delete_all(BusinessOwnerType)
    Repo.delete_all(BusinessType)
  end

  defp seed(data, type) do
    result = do_seed(data, type)

    data
    |> Map.put(type, result)
  end

  defp do_seed(_data, :business_types) do
    business_types_params = [
      %{
        "name" => "Private Limited",
        "semantic_id" => "private_limited",
        "has_shareholding" => true
      },
      %{
        "name" => "Public Limited",
        "semantic_id" => "public_limited",
        "has_shareholding" => true
      },
      %{
        "name" => "Sole Proprietorship",
        "semantic_id" => "sole_proprietorship",
        "has_shareholding" => false
      },
      %{
        "name" => "Limited Liability Partnership",
        "semantic_id" => "limited_liability_partnership",
        "has_shareholding" => false
      },
      %{
        "name" => "Limited by Guarantee",
        "semantic_id" => "limited_by_guarantee",
        "has_shareholding" => false
      }
    ]

    business_types_params
    |> Enum.map(fn bt ->
      Repo.insert!(%BusinessType{} |> BusinessType.changeset(bt),
        on_conflict: :replace_all,
        conflict_target: [:semantic_id]
      )
    end)
  end

  defp do_seed(%{business_types: business_types} = _data, :businesses) do
    business_types
    |> Enum.flat_map(fn business_type ->
      for index <- 1..3 do
        %Business{
          name: "Acme #{get_business_type_slug(business_type.semantic_id)} #{index}",
          registration_number: sequence(:registration_number, &"ACM-XXXXXX#{&1}"),
          registration_date: Faker.Date.backward(1000),
          business_type_id: business_type.id,
          business_type_semantic_id: business_type.semantic_id
        }
        |> Repo.insert!()
        |> Repo.preload(:business_type)
      end
    end)
  end

  defp do_seed(%{businesses: businesses} = _data, :share_categories) do
    share_categories = ["Ordinary", "Preference", "Redeemable"]

    businesses
    |> Enum.map(fn business ->
      if business.business_type.has_shareholding do
        share_categories
        |> Enum.map(fn category ->
          Repo.insert!(%ShareCategory{
            name: category,
            business_id: business.id
          })
        end)
      end
    end)
  end

  defp do_seed(_data, :business_owner_types) do
    owner_types_params = [
      %{
        "name" => "Director",
        "semantic_id" => "director",
        "has_shareholding" => true
      },
      %{
        "name" => "Shareholder",
        "semantic_id" => "shareholder",
        "has_shareholding" => true
      },
      %{
        "name" => "Secretary",
        "semantic_id" => "secretary",
        "has_shareholding" => false
      },
      %{
        "name" => "Director Shareholder",
        "semantic_id" => "director_shareholder",
        "has_shareholding" => true
      },
      %{
        "name" => "Proprietor",
        "semantic_id" => "proprietor",
        "has_shareholding" => true
      },
      %{
        "name" => "Partner",
        "semantic_id" => "partner",
        "has_shareholding" => true
      },
      %{
        "name" => "Manager",
        "semantic_id" => "manager",
        "has_shareholding" => false
      },
      %{
        "name" => "Member",
        "semantic_id" => "member",
        "has_shareholding" => false
      }
    ]

    owner_types_params
    |> Enum.map(fn ot ->
      Repo.insert!(%BusinessOwnerType{} |> BusinessOwnerType.changeset(ot),
        on_conflict: :replace_all,
        conflict_target: [:semantic_id]
      )
    end)
  end

  defp do_seed(_data, :registries) do
    registries_params = [
      %{
        "name" => "Businesses Registry",
        "slug" => "brs",
        "is_default" => true,
        "description" =>
          "The Registry is responsible for registering and maintaining a business entity throughout its life cycle in accordance with applicable laws in Kenya."
      },
      %{
        "name" => "Hire Purchase Registry",
        "slug" => "hp",
        "description" =>
          "The Registry deals with licensing and supervising of Hire Purchase businesses."
      },
      %{
        "name" => "Trustee Registry",
        "slug" => "trustees",
        "description" => "Trust Incorporation"
      },
      %{
        "name" => "MPSR",
        "slug" => "mpsr",
        "description" =>
          "The Registry is an online government notice-based register of security rights in movable property."
      },
      %{
        "name" => "Official Receiver",
        "slug" => "or",
        "description" =>
          "The office administers the Insolvency Act and supports businesses and persons undergoing financial distress"
      }
    ]

    registries_params
    |> Enum.map(fn reg ->
      Repo.insert!(%Registry{} |> Registry.changeset(reg),
        on_conflict: :replace_all,
        conflict_target: [:slug]
      )
    end)
  end

  defp do_seed(%{businesses: businesses} = _data, :business_owners) do
    businesses
    |> Enum.flat_map(fn business ->
      owner_types =
        get_business_type_owner_types(business.business_type.semantic_id)
        |> Stream.cycle()
        |> Enum.take(3)

      Enum.map(owner_types, fn owner_type ->
        Repo.insert!(
          %BusinessOwner{}
          |> BusinessOwner.changeset(%{
            "first_name" => Faker.Person.first_name(),
            "last_name" => Faker.Person.last_name(),
            "other_names" => "Doe",
            "id_number" => "#{Faker.random_between(10_000_000, 99_999_999)}",
            "id_type" => "citizen",
            "business_owner_type_semantic_id" => owner_type,
            "business_id" => business.id
          })
        )
      end)
    end)
  end

  defp do_seed(%{businesses: businesses}, :name_search) do
    [business | _] = businesses

    for _n <- 1..20 do
      generate_name =
        Faker.Company.name()
        |> String.replace([".", "'"], "", global: true)

      attrs = %{
        "name" => generate_name,
        "expires_at" => NaiveDateTime.add(NaiveDateTime.utc_now(), 60),
        "business_type_semantic_id" => business.business_type_semantic_id,
        "business_type_id" => business.business_type_id,
        "business_id" => business.id
      }

      %NameSearch{}
      |> NameSearch.changeset(attrs)
      |> Repo.insert!()
    end
  end

  defp get_business_type_slug(business_type) do
    with {slug, _owner_types} <- @business_types[business_type] do
      slug
    end
  end

  defp get_business_type_owner_types(business_type) do
    with {_slug, owner_types} <- @business_types[business_type] do
      owner_types
    end
  end
end

Brs.Repo.Seeds.run(Mix.env())
