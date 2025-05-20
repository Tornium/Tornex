defmodule Torngen.Client.Schema.TornHofCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornHofCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "level",
    "busts",
    "rank",
    "traveltime",
    "workstats",
    "networth",
    "revives",
    "defends",
    "offences",
    "attacks",
    "awards",
    "racingwins",
    "racingpoints",
    "racingskill"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornHofCategory")
      nil
    end
  end
end
