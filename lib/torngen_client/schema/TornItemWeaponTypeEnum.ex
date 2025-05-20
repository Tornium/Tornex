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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornItemWeaponTypeEnum")
      nil
    end
  end
end
