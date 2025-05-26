defprotocol Brs.Policies.Can do
  @doc """
  Determines whether `actor` can perform the given `action` on the `resource`.
  """
  @spec can?(any, atom, any) :: boolean
  def can?(actor, action, resource)
end
