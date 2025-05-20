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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionNewsCategory")
      nil
    end
  end
end
