defmodule Torngen.Client.Schema.RaceClassEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceClassEnum` of type string.
  """

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
      IO.inspect(data, label: "Invalid enum value of RaceClassEnum")
      nil
    end
  end
end
