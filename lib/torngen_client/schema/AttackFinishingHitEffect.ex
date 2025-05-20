defmodule Torngen.Client.Schema.AttackFinishingHitEffect do
  @moduledoc """
  An enumerated type describing `#/components/schemas/AttackFinishingHitEffect` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["proficience", "stricken", "revitalize", "warlord", "plunder", "irradiate"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of AttackFinishingHitEffect")
      nil
    end
  end
end
