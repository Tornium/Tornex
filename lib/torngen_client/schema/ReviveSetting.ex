defmodule Torngen.Client.Schema.ReviveSetting do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ReviveSetting` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Everyone", "Friends & faction", "No one", "Unknown"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ReviveSetting")
      nil
    end
  end
end
