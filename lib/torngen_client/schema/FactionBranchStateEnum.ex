defmodule Torngen.Client.Schema.FactionBranchStateEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionBranchStateEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["war", "peace"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
