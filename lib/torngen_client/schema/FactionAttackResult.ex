defmodule Torngen.Client.Schema.FactionAttackResult do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "None",
    "Attacked",
    "Mugged",
    "Hospitalized",
    "Arrested",
    "Looted",
    "Lost",
    "Stalemate",
    "Assist",
    "Escape",
    "Timeout",
    "Special",
    "Bounty",
    "Interrupted"
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
      Logger.warning("Invalid enum value #{inspect(data)} of FactionAttackResult")
      nil
    end
  end
end
