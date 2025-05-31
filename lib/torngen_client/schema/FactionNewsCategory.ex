defmodule Torngen.Client.Schema.FactionNewsCategory do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "main",
    "attack",
    "armoryDeposit",
    "armoryAction",
    "territoryWar",
    "rankedWar",
    "territoryGain",
    "chain",
    "crime",
    "membership",
    "depositFunds",
    "giveFunds"
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
      Logger.warning("Invalid enum value #{inspect(data)} of FactionNewsCategory")
      nil
    end
  end
end
