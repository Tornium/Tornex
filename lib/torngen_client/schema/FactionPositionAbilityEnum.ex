defmodule Torngen.Client.Schema.FactionPositionAbilityEnum do
  @moduledoc false

  require Logger

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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of FactionPositionAbilityEnum")
      nil
    end
  end
end
