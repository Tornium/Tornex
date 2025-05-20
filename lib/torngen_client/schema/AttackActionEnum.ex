defmodule Torngen.Client.Schema.AttackActionEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/AttackActionEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "attackerhosp",
    "busy",
    "critical hit",
    "attackerjail",
    "escapefail",
    "hit",
    "hosp",
    "joinfight",
    "leave",
    "loot",
    "lost",
    "missed",
    "mug",
    "noAmmo",
    "onItemUseEff",
    "opponenthosp",
    "opponentjail",
    "paralyzed",
    "reload",
    "runaway",
    "specialTemp",
    "specialTempI",
    "stalemate",
    "startfight",
    "stunned",
    "suppressed",
    "timeout",
    "won"
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
      IO.inspect(data, label: "Invalid enum value of AttackActionEnum")
      nil
    end
  end
end
