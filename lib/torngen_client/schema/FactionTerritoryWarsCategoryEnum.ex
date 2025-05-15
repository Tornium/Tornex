defmodule Torngen.Client.Schema.FactionTerritoryWarsCategoryEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionTerritoryWarsCategoryEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["finsihed", "ongoing"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
