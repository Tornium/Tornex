defmodule Torngen.Client.Schema.PersonalStatsCategoryEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/PersonalStatsCategoryEnum` of type string.
  """

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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of PersonalStatsCategoryEnum")
      nil
    end
  end
end
