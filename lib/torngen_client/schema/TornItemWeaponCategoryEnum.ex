defmodule Torngen.Client.Schema.TornItemWeaponCategoryEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemWeaponCategoryEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Melee", "Secondary", "Primary", "Temporary"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornItemWeaponCategoryEnum")
      nil
    end
  end
end
