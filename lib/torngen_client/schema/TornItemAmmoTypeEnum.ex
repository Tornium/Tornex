defmodule Torngen.Client.Schema.TornItemAmmoTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemAmmoTypeEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Standard", "Hollow Point", "Piercing", "Tracer", "Incendiary"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
