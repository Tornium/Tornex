defmodule Torngen.Client.Schema.FactionCrimeUserOutcome do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionCrimeUserOutcome` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Successful", "Failed", "Jailed", "Injured", "Hospitalized"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
