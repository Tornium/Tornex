defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/UserCrimeUniquesRewardAmmoEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["standard", "special"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
