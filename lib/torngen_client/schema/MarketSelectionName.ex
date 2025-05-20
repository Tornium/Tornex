defmodule Torngen.Client.Schema.MarketSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/MarketSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["itemmarket", "lookup", "timestamp", "pointsmarket", "bazaar"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of MarketSelectionName")
      nil
    end
  end
end
