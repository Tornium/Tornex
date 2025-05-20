defmodule Torngen.Client.Schema.FactionRankEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionRankEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionRankEnum")
      nil
    end
  end
end
