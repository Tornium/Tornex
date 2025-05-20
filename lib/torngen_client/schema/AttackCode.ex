defmodule Torngen.Client.Schema.AttackCode do
  @doc """
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @impl true
  def parse(value), do: value
  # TODO: Validate type of value

  @impl true
  def validate(value), do: Torngen.Client.Schema.validate(value, {:static, :string})
end
