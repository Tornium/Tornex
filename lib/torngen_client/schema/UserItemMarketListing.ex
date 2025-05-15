defmodule Torngen.Client.Schema.UserItemMarketListing do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :item,
    :is_anonymous,
    :id,
    :average_price,
    :available,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          price: integer(),
          item: Torngen.Client.Schema.UserItemMarkeListingItemDetails.t(),
          is_anonymous: boolean(),
          id: integer(),
          average_price: integer(),
          available: integer(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price"),
      item: Map.get(data, "item"),
      is_anonymous: Map.get(data, "is_anonymous"),
      id: Map.get(data, "id"),
      average_price: Map.get(data, "average_price"),
      available: Map.get(data, "available"),
      amount: Map.get(data, "amount")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
