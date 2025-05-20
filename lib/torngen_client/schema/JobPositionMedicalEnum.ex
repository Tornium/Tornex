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

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionMedicalEnum")
      nil
    end
  end
end
