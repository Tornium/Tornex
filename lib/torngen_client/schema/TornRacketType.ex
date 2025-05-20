defmodule Torngen.Client.Schema.TornRacketType do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornRacketType` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Item", "Points", "Money"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornRacketType")
      nil
    end
  end
end
