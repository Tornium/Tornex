defmodule Torngen.Client.Schema.MarketItemMarketResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:itemmarket, :_metadata]

  defstruct [
    :itemmarket,
    :_metadata
  ]

  @type t :: %__MODULE__{
          itemmarket: Torngen.Client.Schema.ItemMarket.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemmarket: data |> Map.get("itemmarket") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemMarket),
      _metadata:
        data |> Map.get("_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:itemmarket, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemMarket)
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
