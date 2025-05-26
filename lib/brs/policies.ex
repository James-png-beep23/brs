defmodule Brs.Policies do
  alias Brs.Policies.Can

  @doc """
  Checks if the `actor` can perform the `action` on the `resource`.
  """
  def can?(actor, action, resource) do
    Can.can?(actor, action, resource)
  end
end
