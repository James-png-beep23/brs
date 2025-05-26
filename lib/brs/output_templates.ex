defmodule Brs.OutputTemplates do
  @moduledoc """
  The OutputTemplates context.
  """

  import Ecto.Query, warn: false
  alias Brs.Repo

  alias Brs.OutputTemplates.OutputTemplate

  @doc """
  Returns the list of output_templates.

  ## Examples

      iex> list_output_templates()
      [%OutputTemplate{}, ...]

  """
  def list_output_templates(service_id) do
    from(q in OutputTemplate, where: q.service_id == ^service_id)
    |> Repo.all()
    |> Repo.preload(:service)
  end

  @doc """
  Gets a single output_template.

  Raises `Ecto.NoResultsError` if the Output template does not exist.

  ## Examples

      iex> get_output_template!(123)
      %OutputTemplate{}

      iex> get_output_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_output_template!(id), do: Repo.get!(OutputTemplate, id) |> Repo.preload(:service)

  @doc """
  Creates a output_template.

  ## Examples

      iex> create_output_template(%{field: value})
      {:ok, %OutputTemplate{}}

      iex> create_output_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_output_template(attrs \\ %{}) do
    %OutputTemplate{}
    |> OutputTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a output_template.

  ## Examples

      iex> update_output_template(output_template, %{field: new_value})
      {:ok, %OutputTemplate{}}

      iex> update_output_template(output_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_output_template(%OutputTemplate{} = output_template, attrs) do
    output_template
    |> OutputTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a output_template.

  ## Examples

      iex> delete_output_template(output_template)
      {:ok, %OutputTemplate{}}

      iex> delete_output_template(output_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_output_template(%OutputTemplate{} = output_template) do
    Repo.delete(output_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking output_template changes.

  ## Examples

      iex> change_output_template(output_template)
      %Ecto.Changeset{data: %OutputTemplate{}}

  """
  def change_output_template(%OutputTemplate{} = output_template, attrs \\ %{}) do
    OutputTemplate.changeset(output_template, attrs)
  end
end
