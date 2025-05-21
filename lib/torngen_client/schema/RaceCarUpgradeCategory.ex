defmodule Torngen.Client.Schema.RaceCarUpgradeCategory do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of RaceCarUpgradeCategory")
      nil
    end
  end
end
