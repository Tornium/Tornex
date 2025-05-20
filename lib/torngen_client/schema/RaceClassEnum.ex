defmodule Torngen.Client.Schema.RaceClassEnum do
  @moduledoc """
  An enumerated type describing `RaceClassEnum` of type string.
  """

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["A", "B", "C", "D", "E"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of RaceClassEnum")
      nil
    end
  end
end
