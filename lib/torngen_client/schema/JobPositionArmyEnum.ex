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

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionArmyEnum")
      nil
    end
  end
end
