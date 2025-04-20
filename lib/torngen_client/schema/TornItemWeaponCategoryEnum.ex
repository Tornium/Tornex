defmodule Torngen.Client.Schema.TornItemWeaponCategoryEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemWeaponCategoryEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Melee", "Secondary", "Primary", "Temporary"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
