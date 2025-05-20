defmodule Torngen.Client.Schema.JobPositionCasinoEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionCasinoEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Gaming Consultant", "Marketing Manager", "Revenue Manager", "Casino Manager", "Casino President"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionCasinoEnum")
      nil
    end
  end
end
