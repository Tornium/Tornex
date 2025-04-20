defmodule Torngen.Client.Schema.JobPositionMedicalEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionMedicalEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Medical Student", "Houseman", "Senior Houseman", "GP", "Consultant", "Surgeon", "Brain Surgeon"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
