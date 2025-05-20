defmodule Torngen.Client.Schema.TornTerritory do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  @behaviour Torngen.Client.Schema

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

  # TODO: Handle required values in schema parser
  @required []
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

  @spec required() :: list(atom())
  def required(), do: @required

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
end
