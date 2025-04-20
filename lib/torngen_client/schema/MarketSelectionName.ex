defmodule Torngen.Client.Schema.MarketSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/MarketSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["itemmarket", "lookup", "timestamp", "pointsmarket"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
