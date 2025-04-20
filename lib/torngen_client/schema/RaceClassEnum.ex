defmodule Torngen.Client.Schema.RaceClassEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceClassEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["A", "B", "C", "D", "E"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
