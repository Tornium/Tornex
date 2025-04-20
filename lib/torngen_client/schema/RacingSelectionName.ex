defmodule Torngen.Client.Schema.RacingSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RacingSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["cars", "carupgrades", "lookup", "race", "races", "records", "timestamp", "tracks"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
