defmodule Torngen.Client.Schema.RaceStatusEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/RaceStatusEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["open", "in_progress", "finished"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
