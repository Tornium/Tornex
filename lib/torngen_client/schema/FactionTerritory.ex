defmodule Torngen.Client.Schema.FactionTerritory do
  @moduledoc """
  """

  @behaviour Torngen.Client.Schema

  defstruct [
    :slots,
    :size,
    :sector,
    :respect,
    :racket,
    :id,
    :density,
    :coordinates,
    :acquired_at
  ]

  # TODO: Handle required values in schema parser
  @required []
  @type t :: %__MODULE__{
          slots: integer(),
          size: integer(),
          sector: integer(),
          respect: integer(),
          racket: nil | Torngen.Client.Schema.TornRacket.t(),
          id: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          density: integer(),
          coordinates: Torngen.Client.Schema.TornTerritoryCoordinates.t(),
          acquired_at: integer()
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
      racket: Map.get(data, "racket"),
      id: Map.get(data, "id"),
      density: Map.get(data, "density"),
      coordinates: Map.get(data, "coordinates"),
      acquired_at: Map.get(data, "acquired_at")
    }

    # TODO: Handle values that are not literals
    # TODO: Handle default values in schema parser and codegen
  end
end
