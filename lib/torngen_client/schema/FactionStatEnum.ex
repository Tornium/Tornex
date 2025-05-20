defmodule Torngen.Client.Schema.FactionStatEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionStatEnum` of type string.
  """

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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionStatEnum")
      nil
    end
  end
end
