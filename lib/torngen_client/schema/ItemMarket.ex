defmodule Torngen.Client.Schema.ItemMarket do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:listings, :item, :cache_timestamp]

  defstruct [
    :listings,
    :item,
    :cache_timestamp
  ]

  @type t :: %__MODULE__{
          listings: [
            Torngen.Client.Schema.ItemMarketListingStackable.t()
            | Torngen.Client.Schema.ItemMarketListingNonstackable.t()
          ],
          item: Torngen.Client.Schema.ItemMarketItem.t(),
          cache_timestamp: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      listings:
        data
        |> Map.get("listings")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:one_of,
            [Torngen.Client.Schema.ItemMarketListingStackable, Torngen.Client.Schema.ItemMarketListingNonstackable]}}
        ),
      item: data |> Map.get("item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketItem),
      cache_timestamp: data |> Map.get("cache_timestamp") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:listings, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:one_of,
        [Torngen.Client.Schema.ItemMarketListingStackable, Torngen.Client.Schema.ItemMarketListingNonstackable]}}
    )
  end

  defp validate_key?(:item, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemMarketItem)
  end

  defp validate_key?(:cache_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
