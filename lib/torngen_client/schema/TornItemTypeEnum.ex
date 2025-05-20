defmodule Torngen.Client.Schema.TornItemTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemTypeEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Alcohol",
    "Armor",
    "Artifact",
    "Book",
    "Booster",
    "Candy",
    "Car",
    "Clothing",
    "Collectible",
    "Drug",
    "Energy Drink",
    "Enhancer",
    "Flower",
    "Jewelry",
    "Material",
    "Medical",
    "Other",
    "Plushie",
    "Special",
    "Supply Pack",
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
      IO.inspect(data, label: "Invalid enum value of TornItemTypeEnum")
      nil
    end
  end
end
