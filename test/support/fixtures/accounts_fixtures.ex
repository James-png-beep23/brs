defmodule Brs.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Brs.Accounts` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        active: true,
        client_ip: "some client_ip",
        expires_at: ~U[2024-07-23 06:55:00Z],
        session_id: "some session_id",
        user_agent: "some user_agent",
        user_id: create_user().id,
        real_user_id: create_user().id
      })
      |> Brs.Accounts.create_session()

    session
  end

  def create_user(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        id_number: "123456789",
        id_type_id: 1,
        email: "test@autom8.com"
      })
      |> Brs.Accounts.create_or_update_user()

    user
  end
end
