defmodule Torngen.Client.Schema.TerritoryWarId do
  @doc """
  """

  @behaviour Torngen.Client.Schema

  @type t :: integer()

  @impl true
  def parse(value), do: value
  # TODO: Validate type of value

  @impl true
  def validate?(value), do: Torngen.Client.Schema.validate?(value, {:static, :integer})
end
