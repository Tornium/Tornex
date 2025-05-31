defmodule Torngen.Client.Schema.TornHofCategory do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of TornHofCategory")
      nil
    end
  end
end
