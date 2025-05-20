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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionAttackResult")
      nil
    end
  end
end
