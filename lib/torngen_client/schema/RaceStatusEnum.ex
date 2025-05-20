defmodule Torngen.Client.Schema.RaceStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["open", "in_progress", "finished"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of RaceStatusEnum")
      nil
    end
  end
end
