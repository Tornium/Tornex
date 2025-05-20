defmodule Torngen.Client.Schema.TornItemWeaponTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemWeaponTypeEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Heavy artillery",
    "Machine gun",
    "Pistol",
    "Rifle",
    "Shotgun",
    "SMG",
    "Temporary",
    "Clubbing",
    "Piercing",
    "Slashing",
    "Mechanical"
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
      IO.inspect(data, label: "Invalid enum value of TornItemWeaponTypeEnum")
      nil
    end
  end
end
