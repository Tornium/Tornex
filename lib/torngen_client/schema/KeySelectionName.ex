defmodule Torngen.Client.Schema.KeySelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/KeySelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["info", "log"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
