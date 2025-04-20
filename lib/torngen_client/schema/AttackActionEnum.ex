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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
