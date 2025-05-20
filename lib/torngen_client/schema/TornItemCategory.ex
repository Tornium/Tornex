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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornItemCategory")
      nil
    end
  end
end
