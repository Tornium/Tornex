defmodule Torngen.Client.Schema.FactionPositionAbilityEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionPositionAbilityEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Medical Item Usage",
    "Booster Item Usage",
    "Drug Item Usage",
    "Energy Refill Usage",
    "Nerve Refill Usage",
    "Temporary Item Loaning",
    "Weapon & Armor Loaning",
    "Item Retrieving",
    "Organised Crimes",
    "Faction API Access",
    "Item Giving",
    "Money Giving",
    "Points Giving",
    "Forum Management",
    "Application Management",
    "Kick Members",
    "Balance Adjustment",
    "War Management",
    "Upgrade Management",
    "Newsletter Sending",
    "Announcement Changes",
    "Description Changes"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
