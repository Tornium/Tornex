defmodule Torngen.Client.Schema.TornItemAmmoTypeEnum do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemAmmoTypeEnum")
      nil
    end
  end
end
