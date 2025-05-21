defmodule Torngen.Client.Schema.AttackFinishingHitEffect do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["proficience", "stricken", "revitalize", "warlord", "plunder", "irradiate"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of AttackFinishingHitEffect")
      nil
    end
  end
end
