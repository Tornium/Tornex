defmodule Torngen.Client.Schema.UserListEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/UserListEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Friends", "Enemies", "Targets"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of UserListEnum")
      nil
    end
  end
end
