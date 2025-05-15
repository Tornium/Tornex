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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          uid: Torngen.Client.Schema.ItemUid.t(),
          stats: Torngen.Client.Schema.ItemMarketListingItemStats.t(),
          rarity: nil | String.t(),
          bonuses: [Torngen.Client.Schema.ItemMarketListingItemBonus.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uid: Map.get(data, "uid"),
      stats: Map.get(data, "stats"),
      rarity: Map.get(data, "rarity"),
      bonuses: Map.get(data, "bonuses")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
