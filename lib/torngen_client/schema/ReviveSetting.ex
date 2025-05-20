defmodule Torngen.Client.Schema.ReviveSetting do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ReviveSetting` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Everyone", "Friends & faction", "No one", "Unknown"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ReviveSetting")
      nil
    end
  end
end
