defmodule Torngen.Client.Schema.ItemMarketListingItemDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :uid,
    :stats,
    :rarity,
    :bonuses
  ]

  @type t :: %__MODULE__{
          uid: Torngen.Client.Schema.ItemUid.t(),
          stats: Torngen.Client.Schema.ItemMarketListingItemStats.t(),
          rarity: nil | String.t(),
          bonuses: [Torngen.Client.Schema.ItemMarketListingItemBonus.t()]
        }
end
