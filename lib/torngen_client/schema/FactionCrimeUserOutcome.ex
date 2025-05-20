defmodule Torngen.Client.Schema.FactionCrimeUserOutcome do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionCrimeUserOutcome` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Successful", "Failed", "Jailed", "Injured", "Hospitalized"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionCrimeUserOutcome")
      nil
    end
  end
end
