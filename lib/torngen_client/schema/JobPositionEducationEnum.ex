defmodule Torngen.Client.Schema.JobPositionEducationEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionEducationEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Recess Supervisor",
    "Substitute Teacher",
    "Elementary Teacher",
    "Secondary Teacher",
    "Professor",
    "Vice-Principal",
    "Principal"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionEducationEnum")
      nil
    end
  end
end
