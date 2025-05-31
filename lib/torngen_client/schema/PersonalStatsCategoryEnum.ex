defmodule Torngen.Client.Schema.PersonalStatsCategoryEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "all",
    "popular",
    "attacking",
    "battle_stats",
    "jobs",
    "trading",
    "jail",
    "hospital",
    "finishing_hits",
    "communication",
    "crimes",
    "bounties",
    "investments",
    "items",
    "travel",
    "drugs",
    "missions",
    "racing",
    "networth",
    "other",
    "itemmarketcustomers",
    "itemmarketsales",
    "itemmarketrevenue",
    "itemmarketfees"
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
      Logger.warning("Invalid enum value #{inspect(data)} of PersonalStatsCategoryEnum")
      nil
    end
  end
end
