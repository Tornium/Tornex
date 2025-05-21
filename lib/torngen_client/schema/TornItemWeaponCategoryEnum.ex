defmodule Torngen.Client.Schema.TornItemWeaponCategoryEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Melee", "Secondary", "Primary", "Temporary"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemWeaponCategoryEnum")
      nil
    end
  end
end
