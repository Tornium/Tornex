defmodule Torngen.Client.Schema.JobPositionArmyEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionArmyEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Private",
    "Corporal",
    "Sergeant",
    "Master Sergeant",
    "Warrant Officer",
    "Lieutenant",
    "Major",
    "Colonel",
    "Brigadier",
    "General"
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
      IO.inspect(data, label: "Invalid enum value of JobPositionArmyEnum")
      nil
    end
  end
end
