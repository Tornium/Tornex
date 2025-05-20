defmodule Torngen.Client.Schema.FactionSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "applications",
    "attacks",
    "attacksfull",
    "balance",
    "basic",
    "chain",
    "chainreport",
    "chains",
    "contributors",
    "crime",
    "crimes",
    "hof",
    "lookup",
    "members",
    "news",
    "rackets",
    "rankedwars",
    "rankedwarreport",
    "revives",
    "revivesfull",
    "stats",
    "territory",
    "territoryownership",
    "territorywarreport",
    "territorywars",
    "timestamp",
    "upgrades",
    "wars",
    "armor",
    "boosters",
    "caches",
    "cesium",
    "crimeexp",
    "drugs",
    "medical",
    "positions",
    "reports",
    "temporary",
    "weapons",
    "armorynews",
    "attacknews",
    "crimenews",
    "currency",
    "donations",
    "fundsnews",
    "mainnews",
    "membershipnews",
    "territorynews"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionSelectionName")
      nil
    end
  end
end
