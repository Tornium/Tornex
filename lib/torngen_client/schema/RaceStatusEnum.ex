defmodule Torngen.Client.Schema.RaceStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["open", "in_progress", "finished"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of RaceStatusEnum")
      nil
    end
  end
end
