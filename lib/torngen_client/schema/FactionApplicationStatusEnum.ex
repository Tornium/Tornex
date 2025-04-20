defmodule Torngen.Client.Schema.FactionApplicationStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionApplicationStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["accepted", "declined", "withdrawn"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
