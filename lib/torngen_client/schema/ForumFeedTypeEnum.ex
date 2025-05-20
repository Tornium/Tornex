defmodule Torngen.Client.Schema.ForumFeedTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ForumFeedTypeEnum` of type integer.
  """

  @behaviour Torngen.Client.Schema

  @type t :: integer()

  @values [1, 2, 3, 4, 5, 6, 7]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values

  def parse(data) do
    if Enum.member?(@values, data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of ForumFeedTypeEnum")
      nil
    end
  end
end
