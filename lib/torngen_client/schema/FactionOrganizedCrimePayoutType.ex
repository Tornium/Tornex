defmodule Torngen.Client.Schema.FactionOrganizedCrimePayoutType do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionOrganizedCrimePayoutType` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["balance", "wallet", "inventory"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionOrganizedCrimePayoutType")
      nil
    end
  end
end
