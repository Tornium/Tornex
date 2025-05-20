defmodule Torngen.Client.Schema.ApiKeyAccessTypeEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/ApiKeyAccessTypeEnum` of type string.
  """

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
      IO.inspect(data, label: "Invalid enum value of ApiKeyAccessTypeEnum")
      nil
    end
  end
end
