defmodule Torngen.Client.Schema.FactionRankedWarsCategoryEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionRankedWarsCategoryEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["all", "ongoing"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionRankedWarsCategoryEnum")
      nil
    end
  end
end
