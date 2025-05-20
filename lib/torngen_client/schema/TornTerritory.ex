defmodule Torngen.Client.Schema.TornTerritory do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:slots, :size, :sector, :respect, :neighbors, :id, :density, :coordinates]

  defstruct [
    :slots,
    :size,
    :sector,
    :respect,
    :neighbors,
    :id,
    :density,
    :coordinates
  ]

  @type t :: %__MODULE__{
          slots: integer(),
          size: integer(),
          sector: integer(),
          respect: integer(),
          neighbors: [Torngen.Client.Schema.FactionTerritoryEnum.t()],
          id: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          density: integer(),
          coordinates: Torngen.Client.Schema.TornTerritoryCoordinates.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      slots: Map.get(data, "slots") |> Torngen.Client.Schema.parse({:static, :integer}),
      size: Map.get(data, "size") |> Torngen.Client.Schema.parse({:static, :integer}),
      sector: Map.get(data, "sector") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: Map.get(data, "respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      neighbors:
        Map.get(data, "neighbors") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryEnum}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      density: Map.get(data, "density") |> Torngen.Client.Schema.parse({:static, :integer}),
      coordinates:
        Map.get(data, "coordinates") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornTerritoryCoordinates)
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

  defp validate_key?(:slots, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:size, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:sector, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:neighbors, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryEnum})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryEnum)
  end

  defp validate_key?(:density, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:coordinates, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornTerritoryCoordinates)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
