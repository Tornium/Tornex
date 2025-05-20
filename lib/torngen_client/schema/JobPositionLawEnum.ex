defmodule Torngen.Client.Schema.JobPositionLawEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionLawEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Law Student", "Paralegal", "Probate Lawyer", "Trial Lawyer", "Circuit Court Judge", "Federal Judge"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionLawEnum")
      nil
    end
  end
end
