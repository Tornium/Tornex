defmodule Torngen.Client.Schema.FactionNewsCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionNewsCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "main",
    "attack",
    "armoryDeposit",
    "armoryAction",
    "territoryWar",
    "rankedWar",
    "territoryGain",
    "chain",
    "crime",
    "membership",
    "depositFunds",
    "giveFunds"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionNewsCategory")
      nil
    end
  end
end
