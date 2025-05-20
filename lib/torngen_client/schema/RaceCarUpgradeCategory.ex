defmodule Torngen.Client.Schema.RaceCarUpgradeCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceCarUpgradeCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Aerodynamics",
    "Brakes",
    "Engine",
    "Exhaust and Induction",
    "Fuel",
    "Safety",
    "Suspension",
    "Transmission",
    "Weight Reduction",
    "Wheels and Tyres"
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
      IO.inspect(data, label: "Invalid enum value of RaceCarUpgradeCategory")
      nil
    end
  end
end
