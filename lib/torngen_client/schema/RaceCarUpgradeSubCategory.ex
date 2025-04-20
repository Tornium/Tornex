defmodule Torngen.Client.Schema.RaceCarUpgradeSubCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceCarUpgradeSubCategory` of type string.
  """

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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
