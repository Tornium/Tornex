defmodule Torngen.Client.Schema.ItemMarketListingNonstackable do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      price: Map.get(data, "price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item_details:
        Map.get(data, "item_details") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarketListingItemDetails),
      amount: Map.get(data, "amount") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:price, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:item_details, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ItemMarketListingItemDetails)
  end

  defp validate_key(:amount, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
