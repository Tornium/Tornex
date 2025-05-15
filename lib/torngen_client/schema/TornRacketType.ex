defmodule Torngen.Client.Schema.TornRacketType do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornRacketType` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Item", "Points", "Money"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
