defmodule Torngen.Client.Schema.TornRacketType do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornRacketType` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Item", "Points", "Money"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornRacketType")
      nil
    end
  end
end
