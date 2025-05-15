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

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          uid: nil | Torngen.Client.Schema.ItemUid.t(),
          type: String.t(),
          stats: nil | Torngen.Client.Schema.ItemMarketListingItemStats.t(),
          rarity: nil | String.t(),
          name: String.t(),
          id: integer(),
          bonuses: [Torngen.Client.Schema.ItemMarketListingItemBonus.t()]
        }

  @spec required() :: list(atom())
  def required(), do: @required

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uid: Map.get(data, "uid"),
      type: Map.get(data, "type"),
      stats: Map.get(data, "stats"),
      rarity: Map.get(data, "rarity"),
      name: Map.get(data, "name"),
      id: Map.get(data, "id"),
      bonuses: Map.get(data, "bonuses")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
