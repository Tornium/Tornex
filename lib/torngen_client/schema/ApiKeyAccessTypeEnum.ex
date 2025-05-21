defmodule Torngen.Client.Schema.ApiKeyAccessTypeEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Custom", "Public Only", "Minimal Access", "Limited Access", "Full Access"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of ApiKeyAccessTypeEnum")
      nil
    end
  end
end
