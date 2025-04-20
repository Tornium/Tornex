defmodule Torngen.Client.Schema.JobPositionGrocerEnum do
  @moduledoc """
  An enumerated type describing `#/components/schemas/JobPositionGrocerEnum` of type string.
  """

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["Bagboy", "Price Labeler", "Cashier", "Food Delivery", "Manager"]

  @spec values() :: [t()]
  def values, do: @values

  @spec valid?(term()) :: boolean()
  def valid?(value), do: value in @values
end
