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
end
