defmodule Torngen.Client.Schema.JobPositionEducationEnum do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of JobPositionEducationEnum")
      nil
    end
  end
end
