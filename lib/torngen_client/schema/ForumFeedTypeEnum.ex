defmodule Torngen.Client.Schema.ForumFeedTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ForumFeedTypeEnum` of type integer.
  """

  @behaviour Torngen.Client.Schema

  @type t :: integer()

  @values [1, 2, 3, 4, 5, 6, 7]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ForumFeedTypeEnum")
      nil
    end
  end
end
