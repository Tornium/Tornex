defmodule Torngen.Client.Schema.ForumFeedTypeEnum do
  @moduledoc false

  require Logger

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
      Logger.warning("Invalid enum value #{inspect(data)} of ForumFeedTypeEnum")
      nil
    end
  end
end
