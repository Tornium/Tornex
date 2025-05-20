defmodule Torngen.Client.Schema.JobPositionMedicalEnum do
  @moduledoc """
  An enumerated type describing `JobPositionMedicalEnum` of type string.
  """

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of JobPositionMedicalEnum")
      nil
    end
  end
end
