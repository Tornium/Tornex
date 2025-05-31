defmodule Torngen.Client.Schema.FactionStatEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "medicalitemsused",
    "criminaloffences",
    "organisedcrimerespect",
    "organisedcrimemoney",
    "organisedcrimesuccess",
    "organisedcrimefail",
    "attackswon",
    "attackslost",
    "attackschain",
    "attacksleave",
    "attacksmug",
    "attackshosp",
    "bestchain",
    "busts",
    "revives",
    "jails",
    "hosps",
    "medicalitemrecovery",
    "medicalcooldownused",
    "gymtrains",
    "gymstrength",
    "gymspeed",
    "gymdefense",
    "gymdexterity",
    "candyused",
    "alcoholused",
    "energydrinkused",
    "drugsused",
    "drugoverdoses",
    "rehabs",
    "caymaninterest",
    "traveltimes",
    "traveltime",
    "hunting",
    "attacksdamagehits",
    "attacksdamage",
    "hosptimegiven",
    "hosptimereceived",
    "attacksdamaging",
    "attacksrunaway",
    "highestterritories",
    "territoryrespect",
    "membersamount",
    "factionage",
    "upgradesamount"
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
      Logger.warning("Invalid enum value #{inspect(data)} of FactionStatEnum")
      nil
    end
  end
end
