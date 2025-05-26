defmodule Brs.Forms.PlcSchema do
  import Ecto.Changeset

  defmodule ShareInformation do
    use Ecto.Schema

    @primary_key false
    embedded_schema do
      field :total_shares, :integer
      field :total_nominal_capital, :float
      embeds_many :shares, __MODULE__.Share, on_replace: :delete
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:total_shares, :total_nominal_capital])
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

  defmodule Ownership do
    use Ecto.Schema
    @primary_key false
    embedded_schema do
      embeds_many :beneficial_owners, Brs.Forms.BeneficialOwner, on_replace: :delete
      embeds_many :shareholders, Brs.Forms.ShareHolder, on_replace: :delete

      field :type_of_secretary, :string
    end

    @doc """
    Creates or updates a changeset for the Ownership schema.
    """
    def changeset(struct, attrs \\ %{}) do
      struct
      |> cast(attrs, [:type_of_secretary])
      |> cast_embed(:beneficial_owners, with: &Brs.Forms.BeneficialOwner.changeset/2)
      |> cast_embed(:shareholders, with: &Brs.Forms.ShareHolder.changeset/2)
      |> validate_required([:type_of_secretary])
    end
  end
end
