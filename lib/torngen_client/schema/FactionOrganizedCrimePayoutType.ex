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

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionOrganizedCrimePayoutType")
      nil
    end
  end
end
