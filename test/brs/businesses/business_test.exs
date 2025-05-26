defmodule Brs.Businesses.BusinessTest do
  use Brs.DataCase

  alias Brs.Repo
  alias Brs.Businesses

  describe "create_business/1" do
    setup do
      business_type = insert(:business_type, name: "Private Limited", has_shareholding: true)

      business_owner_type = insert(:business_owner_type, name: "Director", has_shareholding: true)

      {
        :ok,
        business_type: business_type, business_owner_type: business_owner_type
      }
    end

    test "creates a business with associated owners and share categories", %{
      business_type: business_type,
      business_owner_type: business_owner_type
    } do
      params = %{
        "name" => "Acme Corp",
        "registration_number" => "123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-29],
        "business_type_id" => business_type.id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          },
          %{
            "first_name" => "Jane",
            "last_name" => "Doe",
            "other_names" => "Her",
            "id_number" => "123456789",
            "id_type" => "citizen",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          },
          %{
            "name" => "Class C",
            "number_of_shares" => 20
          }
        ]
      }

      {:ok, business} = Businesses.create_business(params)
      business = Repo.preload(business, [:owners, :share_categories])

      assert business.name == "Acme Corp"
      assert length(business.owners) == 2

      business_owner_type_id = business_owner_type.id

      assert %{
               id_number: "AB123456",
               id_type: "alien",
               business_owner_type_id: ^business_owner_type_id
             } =
               Enum.find(business.owners, fn owner ->
                 owner.id_number == "AB123456" and owner.id_type == "alien"
               end)

      assert length(business.share_categories) == 3

      assert %{name: "Class A"} =
               Enum.find(business.share_categories, fn category ->
                 category.name == "Class A"
               end)
    end

    test "creates a business using valid semantic_id's", %{
      business_type: business_type,
      business_owner_type: business_owner_type
    } do
      params = %{
        "name" => "Acme Corp",
        "registration_number" => "123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-29],
        "business_type_semantic_id" => business_type.semantic_id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_semantic_id" => business_owner_type.semantic_id
          },
          %{
            "first_name" => "Jane",
            "last_name" => "Doe",
            "other_names" => "Her",
            "id_number" => "123456789",
            "id_type" => "citizen",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          },
          %{
            "name" => "Class C",
            "number_of_shares" => 20
          }
        ]
      }

      {:ok, business} = Businesses.create_business(params)
      business = Repo.preload(business, [:owners, :share_categories])

      assert business.name == "Acme Corp"
      assert length(business.owners) == 2

      business_owner_type_id = business_owner_type.id

      assert %{
               id_number: "AB123456",
               id_type: "alien",
               business_owner_type_id: ^business_owner_type_id
             } =
               Enum.find(business.owners, fn owner ->
                 owner.id_number == "AB123456" and owner.id_type == "alien"
               end)

      assert length(business.share_categories) == 3

      assert %{name: "Class A"} =
               Enum.find(business.share_categories, fn category ->
                 category.name == "Class A"
               end)
    end

    test "creates a business type without shareholding, no share categories" do
      business_type = insert(:business_type, name: "Business Name", has_shareholding: false)

      business_owner_type =
        insert(:business_owner_type, name: "Director Shareholder", has_shareholding: true)

      params = %{
        "name" => "Bizna Enterprises",
        "registration_number" => "BN-123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-30],
        "business_type_id" => business_type.id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          }
        ]
      }

      {:ok, business} = Businesses.create_business(params)
      business = Repo.preload(business, [:owners, :share_categories])

      assert business.name == "Bizna Enterprises"
      assert length(business.owners) == 1

      # No share categories for business_type with no shareholding
      assert length(business.share_categories) == 0
    end

    test "creating a business without provided business_type id or semantic_id, should fail", %{
      business_owner_type: business_owner_type
    } do
      params = %{
        "name" => "Acme Corp",
        "registration_number" => "PVT-123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-29],
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_semantic_id" => business_owner_type.semantic_id
          },
          %{
            "first_name" => "Jane",
            "last_name" => "Doe",
            "other_names" => "Her",
            "id_number" => "123456789",
            "id_type" => "citizen",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          },
          %{
            "name" => "Class C",
            "number_of_shares" => 20
          }
        ]
      }

      assert {:error, changeset} = Businesses.create_business(params)

      assert is_nil(Repo.get_by(Businesses.Business, registration_number: "PVT-123456789"))

      assert changeset.errors[:business_type] ==
               {"Either business_type_id or business_type_semantic_id must be provided", []}
    end

    test "creating a business without provided business_owner_type id or semantic_id, should fail",
         %{
           business_type: business_type
         } do
      params = %{
        "name" => "Acme Corp",
        "registration_number" => "PVT-123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-29],
        "business_type_semantic_id" => business_type.semantic_id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active"
          },
          %{
            "first_name" => "Jane",
            "last_name" => "Doe",
            "other_names" => "Her",
            "id_number" => "123456789",
            "id_type" => "citizen",
            "status" => "active"
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          },
          %{
            "name" => "Class C",
            "number_of_shares" => 20
          }
        ]
      }

      assert {:error, changeset} = Businesses.create_business(params)

      assert is_nil(Repo.get_by(Businesses.Business, registration_number: "PVT-123456789"))

      assert changeset.errors[:business_owner_type] ==
               {"Either business_owner_type_id or business_owner_type_semantic_id must be provided",
                []}
    end

    test "creating a business using invalid semantic_id, should fail", %{
      business_owner_type: business_owner_type
    } do
      invalid_business_type_semantic_id = "not_limited"

      params = %{
        "name" => "Acme Corp",
        "registration_number" => "NPVT-123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-29],
        "business_type_semantic_id" => invalid_business_type_semantic_id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_semantic_id" => business_owner_type.semantic_id
          },
          %{
            "first_name" => "Jane",
            "last_name" => "Doe",
            "other_names" => "Her",
            "id_number" => "123456789",
            "id_type" => "citizen",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          },
          %{
            "name" => "Class C",
            "number_of_shares" => 20
          }
        ]
      }

      assert {:error, changeset} = Businesses.create_business(params)

      assert is_nil(Repo.get_by(Businesses.Business, registration_number: "NPVT-123456789"))

      assert changeset.errors[:business_type_semantic_id] ==
               {"Business type not found", []}
    end

    test "creating a business with existing registration_number, should fail", %{
      business_type: business_type,
      business_owner_type: business_owner_type
    } do
      insert(:business, name: "Foo Inc", registration_number: "BN-123456789")

      params = %{
        "name" => "Bizna Enterprises",
        "registration_number" => "BN-123456789",
        "status" => "active",
        "registration_date" => ~D[2024-08-30],
        "business_type_id" => business_type.id,
        "owners" => [
          %{
            "first_name" => "John",
            "last_name" => "Doe",
            "other_names" => "Him",
            "id_number" => "AB123456",
            "id_type" => "alien",
            "status" => "active",
            "business_owner_type_id" => business_owner_type.id
          }
        ],
        "share_categories" => [
          %{
            "name" => "Class A",
            "number_of_shares" => 100
          },
          %{
            "name" => "Class B",
            "number_of_shares" => 50
          }
        ]
      }

      assert {:error, changeset} = Businesses.create_business(params)

      assert changeset.errors[:registration_number] ==
               {"has already been taken",
                [constraint: :unique, constraint_name: "businesses_registration_number_index"]}
    end
  end
end
