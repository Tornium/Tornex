defmodule Torngen.Client.Schema.JobPositionMedicalEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionMedicalEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Medical Student", "Houseman", "Senior Houseman", "GP", "Consultant", "Surgeon", "Brain Surgeon"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionMedicalEnum")
      nil
    end
  end
end
