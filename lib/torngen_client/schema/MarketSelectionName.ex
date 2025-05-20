defmodule Torngen.Client.Schema.MarketSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/MarketSelectionName` of type string.
  """

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
      IO.inspect(data, label: "Invalid enum value of MarketSelectionName")
      nil
    end
  end
end
