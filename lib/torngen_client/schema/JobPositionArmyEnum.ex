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
end
