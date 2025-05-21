defmodule Torngen.Client.Schema.RaceCarUpgradeSubCategory do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Engine Cooling",
    "Front Diffuser",
    "Rear Diffuser",
    "Spoiler",
    "Brake Accessory",
    "Brake Control",
    "Callipers",
    "Discs",
    "Brake Cooling",
    "Fluid",
    "Rear Control Arms",
    "Springs",
    "Upper Front Brace",
    "Clutch",
    "Differential",
    "Flywheel",
    "Gearbox",
    "Shifting",
    "Boot",
    "Hood",
    "Interior",
    "Roof",
    "Steering wheel",
    "Strip out",
    "Windows",
    "Tyres",
    "Wheels",
    "Rear Bushes",
    "Rear Brace",
    "Lower Front Brace",
    "Front Tie Rods",
    "Front Bushes",
    "Seat",
    "Safety Accessory",
    "Roll cage",
    "Overalls",
    "Helmet",
    "Fire Extinguisher",
    "Cut-off",
    "Fuel",
    "Manifold",
    "Exhaust",
    "Air Filter",
    "Turbo",
    "Pistons",
    "Intercooler",
    "Gasket",
    "Fuel Pump",
    "Engine Porting",
    "Engine Cleaning",
    "Computer",
    "Camshaft",
    "Pads"
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
      Logger.warning("Invalid enum value #{inspect(data)} of RaceCarUpgradeSubCategory")
      nil
    end
  end
end
