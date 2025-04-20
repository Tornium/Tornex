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
end
