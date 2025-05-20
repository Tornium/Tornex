defmodule Torngen.Client.Schema.JobPositionLawEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionLawEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Law Student", "Paralegal", "Probate Lawyer", "Trial Lawyer", "Circuit Court Judge", "Federal Judge"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionLawEnum")
      nil
    end
  end
end
