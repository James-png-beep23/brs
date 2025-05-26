defmodule Brs.AccountsTest do
  use Brs.DataCase

  alias Brs.Accounts

  describe "sessions" do
    alias Brs.Accounts.Session

    import Brs.AccountsFixtures

    @invalid_attrs %{
      active: nil,
      client_ip: nil,
      expires_at: nil,
      session_id: nil,
      user_agent: nil
    }

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Accounts.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Accounts.get_session!(session.session_id) == session
    end

    test "create_session/1 with valid data creates a session" do
      user = create_user()

      valid_attrs = %{
        active: true,
        client_ip: "some client_ip",
        expires_at: ~U[2024-07-23 06:55:00Z],
        session_id: "some session_id",
        user_agent: "some user_agent",
        user_id: user.id
      }

      assert {:ok, %Session{} = session} = Accounts.create_session(valid_attrs)
      assert session.active == true
      assert session.client_ip == "some client_ip"
      assert session.user_id == user.id
      assert session.session_id == "some session_id"
      assert session.user_agent == "some user_agent"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      user = create_user()

      update_attrs = %{
        active: false,
        client_ip: "some updated client_ip",
        expires_at: ~U[2024-07-24 06:55:00Z],
        session_id: "some updated session_id",
        user_agent: "some updated user_agent",
        user_id: user.id
      }

      assert {:ok, %Session{} = session} = Accounts.update_session(session, update_attrs)
      assert session.active == false
      assert session.client_ip == "some updated client_ip"
      assert session.user_id == user.id
      assert session.session_id == "some updated session_id"
      assert session.user_agent == "some updated user_agent"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_session(session, @invalid_attrs)
      assert session == Accounts.get_session!(session.session_id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Accounts.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_session!(session.session_id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Accounts.change_session(session)
    end
  end
end
