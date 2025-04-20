defmodule Torngen.Client.Schema.TornFactionHofCategory do
  @moduledoc """
  An enumerated type describing `#/components/schemas/TornFactionHofCategory` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["respect", "chains", "rank"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
