defmodule Brs.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Brs.Accounts.User
  @timeout 300

  @primary_key {:session_id, :string, autogenerate: false}
  schema "sessions" do
    field :active, :boolean, default: true
    field :client_ip, :string
    field :expires_at, :utc_datetime
    field :user_agent, :string
    belongs_to :user, User
    belongs_to :real_user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> set_expires_at(attrs)
    |> cast(attrs, [:session_id, :user_id, :client_ip, :user_agent, :real_user_id, :active])
    |> validate_required([:session_id, :user_id])
  end

  def username_changeset(params \\ %{}) do
    {%{}, %{username: :string, user_type: :string}}
    |> cast(params, [:username, :user_type])
    |> validate_required([:username, :user_type])
  end

  defp set_expires_at(changeset, params) do
    timeout = params[:timeout] || @timeout
    {:ok, expires_at} = expiry_time(timeout)

    changeset
    |> change(expires_at: DateTime.truncate(expires_at, :second))
  end

  defp expiry_time(timeout) do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.add(timeout)
    |> DateTime.from_naive("Etc/UTC")
  end
end
