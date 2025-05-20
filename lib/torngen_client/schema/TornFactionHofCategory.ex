defmodule Torngen.Client.Schema.TornFactionHofCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornFactionHofCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["respect", "chains", "rank"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of TornFactionHofCategory")
      nil
    end
  end
end
