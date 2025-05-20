defmodule Torngen.Client.Schema.ItemMarket do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:listings, :item]

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

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      listings:
        Map.get(data, "listings")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:one_of,
            [Torngen.Client.Schema.ItemMarketListingStackable, Torngen.Client.Schema.ItemMarketListingNonstackable]}}
        ),
      item: Map.get(data, "item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketItem)
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:listings, value) do
    Torngen.Client.Schema.validate(
      value,
      {:array,
       {:one_of,
        [Torngen.Client.Schema.ItemMarketListingStackable, Torngen.Client.Schema.ItemMarketListingNonstackable]}}
    )
  end

  defp validate_key(:item, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ItemMarketItem)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
