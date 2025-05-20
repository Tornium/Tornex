defmodule Torngen.Client.Schema.JobPositionGrocerEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionGrocerEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Bagboy", "Price Labeler", "Cashier", "Food Delivery", "Manager"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      IO.inspect(data, label: "Invalid enum value of JobPositionGrocerEnum")
      nil
    end
  end
end
