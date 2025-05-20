defmodule Torngen.Client.Schema.RacingSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RacingSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["cars", "carupgrades", "lookup", "race", "races", "records", "timestamp", "tracks"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of RacingSelectionName")
      nil
    end
  end
end
