defmodule Torngen.Client.Schema.TornItemCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "All",
    "Alcohol",
    "Armor",
    "Artifact",
    "Book",
    "Booster",
    "Candy",
    "Car",
    "Clothing",
    "Collectible",
    "Defensive",
    "Drug",
    "Energy Drink",
    "Enhancer",
    "Flower",
    "Jewelry",
    "Material",
    "Medical",
    "Melee",
    "Other",
    "Plushie",
    "Primary",
    "Secondary",
    "Special",
    "Supply Pack",
    "Temporary",
    "Tool",
    "Unused",
    "Weapon"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
