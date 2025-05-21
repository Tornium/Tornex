defmodule Torngen.Client.Schema.UserItemMarketListing do
  @moduledoc false

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
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item:
        data |> Map.get("item") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserItemMarkeListingItemDetails),
      is_anonymous: data |> Map.get("is_anonymous") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer}),
      average_price: data |> Map.get("average_price") |> Torngen.Client.Schema.parse({:static, :integer}),
      available: data |> Map.get("available") |> Torngen.Client.Schema.parse({:static, :integer}),
      amount: data |> Map.get("amount") |> Torngen.Client.Schema.parse({:static, :integer})
    }
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
