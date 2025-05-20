defmodule Torngen.Client.Schema.UserItemMarketListing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:price, :item, :is_anonymous, :id, :average_price, :available, :amount]

  defstruct [
    :price,
    :item,
    :is_anonymous,
    :id,
    :average_price,
    :available,
    :amount
  ]

  @type t :: %__MODULE__{
          price: integer(),
          item: Torngen.Client.Schema.UserItemMarkeListingItemDetails.t(),
          is_anonymous: boolean(),
          id: integer(),
          average_price: integer(),
          available: integer(),
          amount: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      price: Map.get(data, "price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item: Map.get(data, "item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserItemMarkeListingItemDetails),
      is_anonymous: Map.get(data, "is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      average_price: Map.get(data, "average_price") |> Torngen.Client.Schema.parse({:static, :integer}),
      available: Map.get(data, "available") |> Torngen.Client.Schema.parse({:static, :integer}),
      amount: Map.get(data, "amount") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:item, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserItemMarkeListingItemDetails)
  end

  defp validate_key?(:is_anonymous, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:average_price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:available, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
