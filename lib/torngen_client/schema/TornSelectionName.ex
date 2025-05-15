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
    "education",
    "factionhof",
    "factiontree",
    "hof",
    "itemammo",
    "itemmods",
    "items",
    "logcategories",
    "logtypes",
    "lookup",
    "subcrimes",
    "territory",
    "timestamp",
    "bank",
    "cards",
    "cityshops",
    "companies",
    "competition",
    "dirtybombs",
    "gyms",
    "honors",
    "itemdetails",
    "itemstats",
    "medals",
    "organisedcrimes",
    "pawnshop",
    "pokertables",
    "properties",
    "raidreport",
    "raids",
    "rockpaperscissors",
    "searchforcash",
    "shoplifting",
    "stats",
    "stocks",
    "chainreport",
    "rackets",
    "rankedwarreport",
    "rankedwars",
    "territorynames",
    "territorywarreport",
    "territorywars"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
