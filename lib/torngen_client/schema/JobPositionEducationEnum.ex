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

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionEducationEnum")
      nil
    end
  end
end
