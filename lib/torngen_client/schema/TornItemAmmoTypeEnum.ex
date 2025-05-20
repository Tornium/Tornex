defmodule Torngen.Client.Schema.TornItemAmmoTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemAmmoTypeEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Standard", "Hollow Point", "Piercing", "Tracer", "Incendiary"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornItemAmmoTypeEnum")
      nil
    end
  end
end
