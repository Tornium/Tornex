defmodule Torngen.Client.Schema.TornSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "attacklog",
    "bounties",
    "calendar",
    "crimes",
    "factionHof",
    "factiontree",
    "hof",
    "itemammo",
    "itemmods",
    "items",
    "logcategories",
    "logtypes",
    "lookup",
    "subcrimes",
    "timestamp",
    "bank",
    "cards",
    "cityshops",
    "companies",
    "competition",
    "dirtybombs",
    "education",
    "gyms",
    "honors",
    "itemdetails",
    "itemstats",
    "medals",
    "organisedcrimes",
    "pawnshop",
    "pokertables",
    "properties",
    "rackets",
    "raidreport",
    "raids",
    "rankedwarreport",
    "rankedwars",
    "rockpaperscissors",
    "searchforcash",
    "shoplifting",
    "stats",
    "stocks",
    "territory",
    "territorynames",
    "territorywarreport",
    "territorywars"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
