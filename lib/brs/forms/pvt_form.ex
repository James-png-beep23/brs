defmodule Brs.Forms.PvtForm do
  import Ecto.Changeset

  defmodule ProposedName do
    use Ecto.Schema

    embedded_schema do
      field :name, :string
      field :affliated, :string
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [
        :name,
        :affliated
      ])
    end
  end

  defmodule ApplicantDetails do
    use Ecto.Schema

    embedded_schema do
      field :first_name, :string
      field :middle_name, :string
      field :last_name, :string
      field :registration_applicant_capacity, :string
      field :ics_number, :string
      field :lsk_number, :string
      field :adv_number, :string
      field :registration_applicant_address, :string
      field :registration_applicant_postal_code, :string
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [
        :first_name,
        :middle_name,
        :last_name,
        :registration_applicant_capacity,
        :ics_number,
        :lsk_number,
        :adv_number,
        :registration_applicant_address,
        :registration_applicant_postal_code
      ])
      |> validate_required([:registration_applicant_address, :registration_applicant_postal_code])
    end
  end

  defmodule RegisteredOfficeAddress do
    use Ecto.Schema

    embedded_schema do
      field :county, :string
      field :district, :string
      field :locality, :string
      field :building, :string
      field :street, :string
      field :floor, :string
      field :room, :string
      field :postal_address, :string
      field :postal_code, :string
      field :mobile_number, :string
      field :email, :string
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [
        :county,
        :district,
        :locality,
        :building,
        :street,
        :floor,
        :room,
        :postal_address,
        :postal_code,
        :mobile_number,
        :email
      ])
      |> validate_required([:county, :district])
    end
  end

  defmodule ArticlesOfAssociation do
    use Ecto.Schema

    embedded_schema do
      field :memorandum, :string
      field :attached_articles, :string
      field :own_articles_of_association, :string
      field :objects_choice, :string
      field :objects_regulated, :string
      field :bs_nature_select, :string
      field :relevant_no_objection_letter, :string
      field :commision_of_university, :string
      field :name_approval_letter, :string
      field :documents, :string
      field :special_economic_zone, :string
      field :kra_business_activity_sector_select, :string
      field :kra_business_activity_division_select, :string
      field :kra_business_activity_group_select, :string
      field :kra_business_activity_class_select, :string
      field :registration_start_date, :string
      field :acc_period_end_month, :string
      field :no_of_employees, :string
      field :estimated_annual_turnover, :string
      field :is_subsidiary, :string
      field :is_subsidiary_resident, :string
      field :subsidiary_kra_pin, :string
      field :subsidiary_name, :string
      field :subsidiary_country, :string
      field :is_amalgamated, :string
      field :bond, :string
      field :registration_company_pin, :string
      field :registration_tax_payer_name, :string
      field :subsidiary_kra_email, :string
      field :amalgamation_date, :string
      field :competition_letter, :string
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [
        :memorandum,
        :attached_articles,
        :own_articles_of_association,
        :objects_choice,
        :objects_regulated,
        :bs_nature_select,
        :relevant_no_objection_letter,
        :commision_of_university,
        :name_approval_letter,
        :documents,
        :special_economic_zone,
        :kra_business_activity_sector_select,
        :kra_business_activity_division_select,
        :kra_business_activity_group_select,
        :kra_business_activity_class_select,
        :registration_start_date,
        :acc_period_end_month,
        :no_of_employees,
        :estimated_annual_turnover,
        :is_subsidiary,
        :is_subsidiary_resident,
        :subsidiary_kra_pin,
        :subsidiary_name,
        :subsidiary_country,
        :is_amalgamated,
        :bond,
        :registration_company_pin,
        :registration_tax_payer_name,
        :subsidiary_kra_email,
        :amalgamation_date,
        :competition_letter
      ])
      |> validate_required([:memorandum, :objects_choice, :is_subsidiary, :is_amalgamated])
    end
  end

  defmodule ShareInformation do
    use Ecto.Schema

    @primary_key false
    embedded_schema do
      embeds_many :shares, __MODULE__.Share, on_replace: :delete
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [])
      |> cast_embed(:shares,
        with: &__MODULE__.Share.changeset/2,
        required: true,
        sort_param: :shares_sort,
        drop_param: :shares_drop
      )
    end

    defmodule Share do
      use Ecto.Schema

      @primary_key false
      embedded_schema do
        field :category, :string
        field :number, :integer
        field :nominal_value, :decimal
        field :other, :string
      end

      def changeset(struct, params) do
        struct
        |> cast(params, [:category, :number, :nominal_value, :other])
        |> validate_required([:category, :number, :nominal_value])
        |> validate_inclusion(:category, ["PREFERENCE", "ORDINARY", "OTHER"])
        |> validate_number(:number, greater_than: 0)
        |> validate_number(:nominal_value, greater_than: 0)
        |> validate_other_category()
      end

      defp validate_other_category(changeset) do
        case get_field(changeset, :category) do
          "OTHER" ->
            validate_required(changeset, [:other])

          _ ->
            changeset
        end
      end
    end
  end
end
