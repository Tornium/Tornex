defmodule Torngen.Client.Schema.FactionOrganizedCrimePayoutType do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionOrganizedCrimePayoutType` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["balance", "wallet", "inventory"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
