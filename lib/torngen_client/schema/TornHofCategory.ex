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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornHofCategory")
      nil
    end
  end
end
