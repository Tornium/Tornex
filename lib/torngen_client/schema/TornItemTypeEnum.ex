defmodule Torngen.Client.Schema.TornItemTypeEnum do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemTypeEnum")
      nil
    end
  end
end
