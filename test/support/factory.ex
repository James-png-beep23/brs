defmodule Brs.TestFactory do
  use ExMachina.Ecto, repo: Brs.Repo

  def business_type_factory do
    business_types = [
      {"Business Name", "business_name"},
      {"Private Limited", "private_limited"},
      {"Public Limited", "public_limited"},
      {"Limited By Guarantee", "limited_by_guarantee"},
      {"Limited Liability Partnership", "limited_liability_partnership"}
    ]

    {name, semantic_id} = Enum.random(business_types)

    %Brs.Businesses.BusinessType{
      name: "#{name}_#{System.unique_integer([:positive])}",
      semantic_id: "#{semantic_id}_#{System.unique_integer([:positive])}",
      has_shareholding: true
    }
  end

  def business_factory(attrs) do
    business_type = insert(:business_type)

    business = %Brs.Businesses.Business{
      business_type_id: business_type.id,
      business_type_semantic_id: business_type.semantic_id,
      name: sequence(:name, &"Foo #{&1} Inc"),
      registration_number: sequence(:business_params_registration, &"PVT-XXXXXX#{&1}"),
      status: "active",
      registration_date: Date.utc_today()
    }

    business
    |> merge_attributes(attrs)
    |> evaluate_lazy_attributes()
  end

  def share_category_factory do
    %Brs.Businesses.ShareCategory{
      business: build(:business),
      name: sequence(:name, &"Share Category #{&1}"),
      number_of_shares: 100
    }
  end

  def business_owner_type_factory do
    owner_types = [
      {"Director", "director"},
      {"Shareholder", "shareholder"},
      {"Partner", "partner"},
      {"Member", "member"}
    ]

    {name, semantic_id} = Enum.random(owner_types)

    %Brs.Businesses.BusinessOwnerType{
      name: "#{name}_#{System.unique_integer([:positive])}",
      semantic_id: "#{semantic_id}_#{System.unique_integer([:positive])}",
      has_shareholding: true
    }
  end

  def business_owner_factory do
    %Brs.Businesses.BusinessOwner{
      # business: build(:business),
      business_owner_type: build(:business_owner_type),
      first_name: sequence(:first_name, &"John#{&1}"),
      last_name: sequence(:last_name, &"Doe#{&1}"),
      other_names: sequence(:other_names, &"Doe#{&1}"),
      id_number: sequence(:id_number, &"123456#{&1}"),
      id_type: Enum.random(["citizen", "alien", "business", "visitor"])
    }
  end
end
