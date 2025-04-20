defmodule Torngen.Client.Schema.JobPositionCasinoEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionCasinoEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Gaming Consultant", "Marketing Manager", "Revenue Manager", "Casino Manager", "Casino President"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
