defmodule Torngen.Client.Schema.ItemMarketListingNonstackable do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:price, :item_details, :amount]

  defstruct [
    :price,
    :item_details,
    :amount
  ]

  @type t :: %__MODULE__{
          price: integer(),
          item_details: Torngen.Client.Schema.ItemMarketListingItemDetails.t(),
          amount: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item_details:
        data
        |> Map.get("item_details")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketListingItemDetails),
      amount: data |> Map.get("amount") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:item_details, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemMarketListingItemDetails)
  end

  defp validate_key?(:amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
