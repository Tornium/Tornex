defmodule Torngen.Client.Schema.ForumSelectionName do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ForumSelectionName` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["categories", "lookup", "posts", "thread", "threads", "timestamp"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ForumSelectionName")
      nil
    end
  end
end
