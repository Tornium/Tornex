defmodule Torngen.Client.Schema.UserListEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/UserListEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Friends", "Enemies", "Targets"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
