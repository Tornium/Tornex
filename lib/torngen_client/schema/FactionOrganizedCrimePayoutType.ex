defmodule Torngen.Client.Schema.FactionOrganizedCrimePayoutType do
  @moduledoc """
  An enumerated type describing `FactionOrganizedCrimePayoutType` of type string.
  """

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of FactionOrganizedCrimePayoutType")
      nil
    end
  end
end
