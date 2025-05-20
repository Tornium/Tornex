defmodule Torngen.Client.Schema.TornSelectionName do
  @moduledoc """
  An enumerated type describing `TornSelectionName` of type string.
  """

  require Logger

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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of TornSelectionName")
      nil
    end
  end
end
