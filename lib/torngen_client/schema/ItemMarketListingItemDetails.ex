defmodule Torngen.Client.Schema.ItemMarketListingItemDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      uid: Map.get(data, "uid") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemUid),
      stats: Map.get(data, "stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketListingItemStats),
      rarity:
        Map.get(data, "rarity")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]}),
      bonuses:
        Map.get(data, "bonuses")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ItemMarketListingItemBonus})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
