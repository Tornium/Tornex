defmodule Torngen.Client.Schema.FactionCrimeStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/FactionCrimeStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Recruiting", "Planning", "Successful", "Failure", "Expired"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of FactionCrimeStatusEnum")
      nil
    end
  end
end
