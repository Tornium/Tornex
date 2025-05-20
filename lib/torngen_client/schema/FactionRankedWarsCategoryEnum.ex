defmodule Torngen.Client.Schema.FactionRankedWarsCategoryEnum do
  @moduledoc """
  An enumerated type describing `FactionRankedWarsCategoryEnum` of type string.
  """

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["all", "ongoing"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of FactionRankedWarsCategoryEnum")
      nil
    end
  end
end
