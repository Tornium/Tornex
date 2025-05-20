defmodule Torngen.Client.Schema.FactionAttackResult do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionAttackResult` of type string.
  """

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
      IO.inspect(data, label: "Invalid enum value of FactionAttackResult")
      nil
    end
  end
end
