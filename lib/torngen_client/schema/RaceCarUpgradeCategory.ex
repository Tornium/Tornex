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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
