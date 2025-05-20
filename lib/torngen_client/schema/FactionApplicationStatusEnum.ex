defmodule Torngen.Client.Schema.FactionApplicationStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionApplicationStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["accepted", "declined", "withdrawn"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionApplicationStatusEnum")
      nil
    end
  end
end
