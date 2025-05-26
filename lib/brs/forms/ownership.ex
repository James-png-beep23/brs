defmodule Brs.Forms.Ownership do
  use Ecto.Schema
  import Ecto.Changeset

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

defmodule Brs.Forms.BeneficialOwner do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :designation, :string
    field :phone_number, :string
    field :type, :string
    field :id_type, :string
    field :citizenship, :string
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :id_number, :string
    field :date_of_birth, :date
    field :gender, :string
    field :kra_pin, :string
    field :email, :string
    field :passport_photo, :string
    field :postal_address, :string
    field :postal_code, :string
    field :occupation, :string
    field :county, :string
    field :district, :string
    field :locality, :string
    field :building, :string
    field :street, :string
    field :floor, :string
    field :room, :string
    embeds_one :share_information, Brs.Forms.ShareInformation, on_replace: :delete
  end

  @doc """
  Creates or updates a changeset for the BeneficialOwner schema.
  """
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :designation,
      :phone_number,
      :type,
      :id_type,
      :citizenship,
      :first_name,
      :middle_name,
      :last_name,
      :id_number,
      :date_of_birth,
      :gender,
      :kra_pin,
      :email,
      :passport_photo,
      :postal_address,
      :postal_code,
      :occupation,
      :county,
      :district,
      :locality,
      :building,
      :street,
      :floor,
      :room
    ])
    |> cast_embed(:share_information, with: &Brs.Forms.ShareInformation.changeset/2)
    |> validate_required([:designation, :first_name, :last_name, :id_type, :id_number])
    |> validate_length(:phone_number, min: 10, max: 15)
  end
end

defmodule Brs.Forms.ShareHolder do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :designation, :string
    field :street, :string
    field :question_29, :string
    field :postal_code, :string
    field :postal_address, :string
    field :locality, :string
    field :kra_pin, :string
    field :id_type, :string
    field :id_number, :string
    field :fullname, :string
    field :district, :string
    field :middle_name, :string
    field :last_name, :string
    field :gender, :string
    field :first_name, :string
    field :date_of_birth, :date
    field :county, :string
    field :building, :string
    field :source_of_information, :string
    field :effective_date, :date
    field :occupation, :string
    field :passport_photo, :string
    field :phone_number, :string
    field :email, :string
    field :service_address, :string
    embeds_one :share_information, Brs.Forms.ShareInformation, on_replace: :delete
  end

  @doc """
  Creates or updates a changeset for the ShareHolder schema.
  """
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :designation,
      :street,
      :question_29,
      :postal_code,
      :postal_address,
      :locality,
      :kra_pin,
      :id_type,
      :id_number,
      :fullname,
      :district,
      :middle_name,
      :last_name,
      :gender,
      :first_name,
      :date_of_birth,
      :county,
      :building,
      :source_of_information,
      :effective_date,
      :occupation,
      :passport_photo,
      :phone_number,
      :email,
      :service_address
    ])
    |> cast_embed(:share_information, with: &Brs.Forms.ShareInformation.changeset/2)
    |> validate_required([
      :designation,
      :building,
      :first_name,
      :last_name,
      :date_of_birth,
      :kra_pin,
      :gender,
      :email,
      :phone_number,
      :postal_address,
      :postal_code,
      :occupation
    ])
    |> validate_length(:phone_number, min: 10, max: 15)
  end
end

defmodule Brs.Forms.ShareInformation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :direct_shareownership, :integer
    field :total_voting_rights, :integer
    field :direct_voting_rights, :integer
    field :type_of_influence, :string
    field :rights_to_appoint_directors, :string
    field :indirect_shares, :map
    field :indirect_voting_rights, :map
    field :shareholder_id, :string
    field :full_name, :string
    field :id_number, :string
    field :percentage, :float

    embeds_many :shares, Brs.Forms.Shares, on_replace: :delete
  end

  @doc """
  Creates or updates a changeset for the ShareInformation schema.
  """
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :direct_shareownership,
      :total_voting_rights,
      :direct_voting_rights,
      :type_of_influence,
      :rights_to_appoint_directors,
      :indirect_shares,
      :indirect_voting_rights,
      :shareholder_id,
      :full_name,
      :id_number,
      :percentage
    ])
    |> cast_embed(:shares, with: &Brs.Forms.Shares.changeset/2)
    |> validate_shareownership_percentage()
  end

  def add_shares(data, attrs \\ %{}) do
    share_information =
      data.share_information
      |> case do
        nil ->
          %Brs.Forms.ShareInformation{shares: attrs.shares, percentage: attrs.percentage}

        share_info ->
          updated_shares =
            Enum.reduce(attrs.shares, share_info.shares || [], fn new_share, acc ->
              acc
              |> Enum.map(fn existing_share ->
                if existing_share.name == new_share.name,
                  do: Map.merge(existing_share, new_share),
                  else: existing_share
              end)
              |> then(fn merged_shares ->
                if Enum.any?(merged_shares, &(&1.name == new_share.name)),
                  do: merged_shares,
                  else: merged_shares ++ [new_share]
              end)
            end)

          %{share_info | shares: updated_shares, percentage: attrs.percentage}
      end

    %{data | share_information: share_information}
  end

  def update_indirect_shares(data, attrs \\ %{}) do
    share_information =
      data.share_information
      |> case do
        nil ->
          %Brs.Forms.ShareInformation{indirect_shares: attrs}

        share_info ->
          %{share_info | indirect_shares: attrs}
      end

    %{data | share_information: share_information}
  end

  def update_voting_rights(data, attrs \\ %{}) do
    share_information =
      data.share_information
      |> case do
        nil ->
          %Brs.Forms.ShareInformation{indirect_voting_rights: attrs}

        share_info ->
          %{share_info | indirect_voting_rights: attrs}
      end

    %{data | share_information: share_information}
  end

  defp validate_shareownership_percentage(changeset) do
    direct_shareownership = get_field(changeset, :direct_shareownership) || 0
    percentage = get_field(changeset, :percentage) || 0

    if direct_shareownership > percentage do
      add_error(changeset, :direct_shareownership, "cannot be greater than percentage")
    else
      changeset
    end
  end
end

defmodule Brs.Forms.Shares do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
    field :issued, :integer
    field :shares_paidup, :integer
    field :percentage, :float
  end

  @doc """
  Creates or updates a changeset for the Shares schema.
  """
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :issued, :shares_paidup, :percentage])
  end
end
