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

  @type t :: %__MODULE__{
          price: integer(),
          item_details: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          itemDetails: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          amount: integer()
        }
end
