defmodule Torngen.Client.Schema.JobPositionCasinoEnum do
  @moduledoc """
  An enumerated type describing `JobPositionCasinoEnum` of type string.
  """

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Gaming Consultant", "Marketing Manager", "Revenue Manager", "Casino Manager", "Casino President"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of JobPositionCasinoEnum")
      nil
    end
  end
end
