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

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ForumSelectionName")
      nil
    end
  end
end
