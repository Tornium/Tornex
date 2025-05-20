defmodule Torngen.Client.Schema.FactionBranchStateEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionBranchStateEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["war", "peace"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionBranchStateEnum")
      nil
    end
  end
end
