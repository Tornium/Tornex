defmodule Torngen.Client.Schema.TornItemArmorCoveragePartEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornItemArmorCoveragePartEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Full Body", "Heart", "Stomach", "Chest", "Arm", "Groin", "Leg", "Throat", "Hand", "Foot", "Head"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornItemArmorCoveragePartEnum")
      nil
    end
  end
end
