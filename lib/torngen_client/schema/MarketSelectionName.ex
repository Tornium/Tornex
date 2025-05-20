defmodule Torngen.Client.Schema.MarketSelectionName do
  @moduledoc """
  An enumerated type describing `MarketSelectionName` of type string.
  """

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["itemmarket", "lookup", "timestamp", "pointsmarket", "bazaar"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of MarketSelectionName")
      nil
    end
  end
end
