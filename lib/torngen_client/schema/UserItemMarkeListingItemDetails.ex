defmodule Torngen.Client.Schema.UserItemMarkeListingItemDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
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
      uid:
        Map.get(data, "uid")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemUid]}),
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse({:static, :string}),
      stats:
        Map.get(data, "stats")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemMarketListingItemStats]}),
      rarity:
        Map.get(data, "rarity")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      bonuses:
        Map.get(data, "bonuses")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ItemMarketListingItemBonus})
    }

    # TODO: Handle default values in schema parser and codegen
  end
end
