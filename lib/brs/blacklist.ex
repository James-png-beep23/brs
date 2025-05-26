defmodule Brs.Blacklist do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias Brs.Repo

  alias Brs.Accounts.User

  schema "blacklists" do
    field :active, :boolean, default: true
    field :reason, :string
    belongs_to :blacklisted_by, User
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(blacklist, attrs) do
    blacklist
    |> cast(attrs, [:user_id, :reason, :active, :blacklisted_by_id])
    |> validate_required([:user_id, :reason, :active, :blacklisted_by_id])
    |> unique_constraint(:user_id,
      name: "blacklists_user_id_blacklisted_by_id_index",
      message: "Already blacklisted"
    )
    |> check_constraint(:user_id,
      name: :user_id_must_be_not_same_as_blacklisted_by_id,
      message: "You cannot blacklist yourself"
    )
  end

  def new(params), do: changeset(%__MODULE__{}, params)

  def create(params) do
    new(params)
    |> Repo.insert()
  end

  def update(blacklist, params) do
    changeset(blacklist, params)
    |> Repo.update()
  end

  def blacklisted_users_ids() do
    from(b in __MODULE__, where: b.active, join: u in assoc(b, :user), preload: [user: u])
    |> Repo.all()
    |> Enum.map(& &1.user_id)
  end

  def get_all_by_user_id_query(user_id) do
    from(b in __MODULE__,
      where: b.user_id == ^user_id,
      join: u in assoc(b, :blacklisted_by),
      order_by: [desc: b.inserted_at],
      preload: [blacklisted_by: u]
    )
  end

  def get_all_by_user_id(user_id), do: Repo.all(get_all_by_user_id_query(user_id))

  def get_active_by_user_id(user_id) do
    from(b in __MODULE__,
      where: b.user_id == ^user_id,
      where: b.active
    )
    |> Repo.one()
  end
end
