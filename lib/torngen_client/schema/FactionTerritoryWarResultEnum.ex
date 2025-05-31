defmodule Torngen.Client.Schema.FactionTerritoryWarResultEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "success_assault",
    "fail_assault",
    "end_with_nap",
    "end_with_destroy_attack",
    "end_with_destroy_defense",
    "end_with_peace_treaty"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of FactionTerritoryWarResultEnum")
      nil
    end
  end
end
