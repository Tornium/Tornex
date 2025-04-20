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

  @type t :: %__MODULE__{
          price: integer(),
          item: Torngen.Client.Schema.UserItemMarkeListingItemDetails.t(),
          is_anonymous: boolean(),
          id: integer(),
          average_price: integer(),
          available: integer(),
          amount: integer()
        }
end
