defmodule Torngen.Client.Schema.UserItemMarkeListingItemDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uid, :type, :stats, :rarity, :name, :id, :bonuses]

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

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:uid, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.ItemUid]})
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:stats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.ItemMarketListingItemStats]}
    )
  end

  defp validate_key?(:rarity, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:bonuses, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ItemMarketListingItemBonus})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
