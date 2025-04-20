defmodule Torngen.Client.Schema.ReviveSetting do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ReviveSetting` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Everyone", "Friends & faction", "No one", "Unknown"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
