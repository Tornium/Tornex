defmodule Torngen.Client.Schema.ApiKeyAccessTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ApiKeyAccessTypeEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Custom", "Public Only", "Minimal Access", "Limited Access", "Full Access"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
