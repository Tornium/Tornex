defmodule Torngen.Client.Schema.WeaponBonusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/WeaponBonusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Any",
    "Double",
    "Yellow",
    "Orange",
    "Red",
    "Achilles",
    "Assassinate",
    "Backstab",
    "Berserk",
    "Bleed",
    "Blindfire",
    "Blindside",
    "Bloodlust",
    "Burn",
    "Comeback",
    "Conserve",
    "Cripple",
    "Crusher",
    "Cupid",
    "Deadeye",
    "Deadly",
    "Demoralize",
    "Disarm",
    "Double-edged",
    "Double Tap",
    "Emasculate",
    "Empower",
    "Eviscerate",
    "Execute",
    "Expose",
    "Finale",
    "Focus",
    "Freeze",
    "Frenzy",
    "Fury",
    "Grace",
    "Hazardous",
    "Home run",
    "Irradiate",
    "Lacerate",
    "Motivation",
    "Paralyze",
    "Parry",
    "Penetrate",
    "Plunder",
    "Poison",
    "Powerful",
    "Proficience",
    "Puncture",
    "Quicken",
    "Rage",
    "Revitalize",
    "Roshambo",
    "Shock",
    "Sleep",
    "Slow",
    "Smash",
    "Smurf",
    "Specialist",
    "Spray",
    "Storage",
    "Stricken",
    "Stun",
    "Suppress",
    "Sure Shot",
    "Throttle",
    "Toxin",
    "Warlord",
    "Weaken",
    "Wind-up",
    "Wither"
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
      IO.inspect(data, label: "Invalid enum value of WeaponBonusEnum")
      nil
    end
  end
end
