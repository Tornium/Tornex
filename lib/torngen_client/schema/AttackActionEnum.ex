defmodule Torngen.Client.Schema.AttackActionEnum do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of AttackActionEnum")
      nil
    end
  end
end
