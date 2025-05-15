defmodule Torngen.Client.Schema.ItemMarketListingNonstackable do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :price,
    :item_details,
    :itemDetails,
    :amount
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          price: integer(),
          item_details: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          itemDetails: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          amount: integer()
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price"),
      item_details: Map.get(data, "item_details"),
      itemDetails: Map.get(data, "itemDetails"),
      amount: Map.get(data, "amount")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
