defmodule Torngen.Client.Schema.UserItemMarkeListingItemDetails do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :uid,
    :type,
    :stats,
    :rarity,
    :name,
    :id,
    :bonuses
  ]

  @type t :: %__MODULE__{
          uid: nil | Torngen.Client.Schema.ItemUid.t(),
          type: String.t(),
          stats: nil | Torngen.Client.Schema.ItemMarketListingItemStats.t(),
          rarity: nil | String.t(),
          name: String.t(),
          id: integer(),
          bonuses: [Torngen.Client.Schema.ItemMarketListingItemBonus.t()]
        }
end
