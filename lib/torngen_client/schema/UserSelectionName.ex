defmodule Torngen.Client.Schema.UserSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/UserSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "attacks",
    "attacksfull",
    "bounties",
    "calendar",
    "crimes",
    "enlistedcars",
    "factionbalance",
    "forumfeed",
    "forumfriends",
    "forumposts",
    "forumsubscribedthreads",
    "forumthreads",
    "hof",
    "itemmarket",
    "jobranks",
    "list",
    "lookup",
    "organizedcrime",
    "personalstats",
    "races",
    "revives",
    "revivesfull",
    "timestamp",
    "ammo",
    "bars",
    "basic",
    "battlestats",
    "bazaar",
    "cooldowns",
    "criminalrecord",
    "discord",
    "display",
    "education",
    "equipment",
    "events",
    "gym",
    "honors",
    "icons",
    "inventory",
    "jobpoints",
    "log",
    "medals",
    "merits",
    "messages",
    "missions",
    "money",
    "networth",
    "newevents",
    "newmessages",
    "notifications",
    "perks",
    "profile",
    "properties",
    "refills",
    "reports",
    "skills",
    "stocks",
    "travel",
    "weaponexp",
    "workstats"
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
      IO.inspect(data, label: "Invalid enum value of UserSelectionName")
      nil
    end
  end
end
