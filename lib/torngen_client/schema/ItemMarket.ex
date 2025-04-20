defmodule Torngen.Client.Schema.ItemMarket do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :listings,
    :item
  ]

  @type t :: %__MODULE__{
          listings: [
            Torngen.Client.Schema.ItemMarketListingStackable.t()
            | Torngen.Client.Schema.ItemMarketListingNonstackable.t()
          ],
          item: Torngen.Client.Schema.ItemMarketItem.t()
        }
end
