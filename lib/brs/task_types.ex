defmodule Brs.TaskTypes do
  @moduledoc """
  The TaskTypes context.
  """

  import Ecto.Query, warn: false
  alias Brs.Repo

  alias Brs.TaskTypes.TaskType

  def list_task_types(service_id) do
    Repo.all(from q in TaskType, where: q.service_id == ^service_id)
  end

  def get_task_type!(id), do: Repo.get!(TaskType, id)

  def create_task_type(attrs \\ %{}) do
    %TaskType{}
    |> TaskType.changeset(attrs)
    |> Repo.insert()
  end

  def update_task_type(%TaskType{} = task_type, attrs) do
    task_type
    |> TaskType.changeset(attrs)
    |> Repo.update()
  end

  def delete_task_type(%TaskType{} = task_type) do
    Repo.delete(task_type)
  end

  def change_task_type(%TaskType{} = task_type, attrs \\ %{}) do
    TaskType.changeset(task_type, attrs)
  end

  def preload_service(record_or_records) do
    Repo.preload(record_or_records, :service)
  end

  def preload_actions(record_or_records) do
    Repo.preload(record_or_records, :actions)
  end

  def preload_roles(record_or_records) do
    Repo.preload(record_or_records, [roles: [:role]])
  end

  alias Brs.TaskTypes.Action

  def list_task_type_actions do
    Repo.all(Action)
  end

  def get_action!(id), do: Repo.get!(Action, id)

  def create_action(attrs \\ %{}) do
    %Action{}
    |> Action.changeset(attrs)
    |> Repo.insert()
  end

  def update_action(%Action{} = action, attrs) do
    action
    |> Action.changeset(attrs)
    |> Repo.update()
  end

  def delete_action(%Action{} = action) do
    Repo.delete(action)
  end

  def change_action(%Action{} = action, attrs \\ %{}) do
    Action.changeset(action, attrs)
  end

  alias Brs.TaskTypes.Role

  def list_task_type_roles do
    Repo.all(Role)
  end

  def get_role!(id), do: Repo.get!(Role, id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end
end
