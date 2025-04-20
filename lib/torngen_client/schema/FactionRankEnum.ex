defmodule Torngen.Client.Schema.FactionRankEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionRankEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
