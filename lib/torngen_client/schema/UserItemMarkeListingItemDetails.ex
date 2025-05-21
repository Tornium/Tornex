defmodule Torngen.Client.Schema.UserItemMarkeListingItemDetails do
  @moduledoc false

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
        data
        |> Map.get("uid")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemUid]}),
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:static, :string}),
      stats:
        data
        |> Map.get("stats")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemMarketListingItemStats]}),
      rarity:
        data
        |> Map.get("rarity")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer}),
      bonuses:
        data
        |> Map.get("bonuses")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ItemMarketListingItemBonus})
    }
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
