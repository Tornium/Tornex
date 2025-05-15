defmodule Torngen.Client.Schema.TornTerritory do
  @moduledoc """
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
      slots: Map.get(data, "slots"),
      size: Map.get(data, "size"),
      sector: Map.get(data, "sector"),
      respect: Map.get(data, "respect"),
      neighbors: Map.get(data, "neighbors"),
      id: Map.get(data, "id"),
      density: Map.get(data, "density"),
      coordinates: Map.get(data, "coordinates")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
