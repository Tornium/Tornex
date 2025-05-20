defmodule Torngen.Client.Schema.UserCrimeUniquesRewardAmmoEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/UserCrimeUniquesRewardAmmoEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["standard", "special"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of UserCrimeUniquesRewardAmmoEnum")
      nil
    end
  end
end
