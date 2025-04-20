defmodule Torngen.Client.Schema.ForumSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ForumSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["categories", "lookup", "posts", "thread", "threads", "timestamp"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
