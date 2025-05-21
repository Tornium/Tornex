defmodule Torngen.Client.Schema.TornItemArmorCoveragePartEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Full Body", "Heart", "Stomach", "Chest", "Arm", "Groin", "Leg", "Throat", "Hand", "Foot", "Head"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemArmorCoveragePartEnum")
      nil
    end
  end
end
