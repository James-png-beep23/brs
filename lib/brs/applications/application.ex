defmodule Brs.Applications.Application do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "applications" do
    field :application_number, :string
    belongs_to :account, Brs.Accounts.Account
    belongs_to :created_by, Brs.Accounts.User, foreign_key: :created_by_id
    belongs_to :submitted_by, Brs.Accounts.User, foreign_key: :submitted_by_id
    belongs_to :service, Brs.Services.Service
    belongs_to :form, Brs.Forms.Form
    field :submitted_at, :naive_datetime
    field :form_data, :map
    field :status, :string

    timestamps()
  end

  def changeset(application, attrs) do
    application
    |> cast(attrs, [
      :application_number,
      :account_id,
      :created_by_id,
      :submitted_by_id,
      :submitted_at,
      :service_id,
      :form_id,
      :form_data,
      :status
    ])
    |> validate_required([
      :application_number,
      :account_id,
      :created_by_id,
      :submitted_by_id,
      :service_id,
      :form_id
    ])
  end

  def user_applications_query(user) do
    from(n in __MODULE__, where: n.user_id == ^user.id, order_by: [desc: :id])
  end

  def account_applications_query(account) do
    from(n in __MODULE__, where: n.account_id == ^account.id, order_by: [desc: :inserted_at])
  end

  def appl_number_query(query \\ __MODULE__, application_number)

  def appl_number_query(query, application_number) when application_number in ["", nil], do: query

  def appl_number_query(query, application_number) do
    application_number =
      application_number
      |> String.trim()
      |> String.upcase()

    from(n in query,
      where: n.application_number == ^application_number,
      order_by: [asc: :id]
    )
  end

  def join_service_query(query \\ __MODULE__) do
    from(u in query, join: s in assoc(u, :service), preload: [service: s])
  end
end
