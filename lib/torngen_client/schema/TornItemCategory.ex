defmodule Torngen.Client.Schema.TornItemCategory do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemCategory")
      nil
    end
  end
end
