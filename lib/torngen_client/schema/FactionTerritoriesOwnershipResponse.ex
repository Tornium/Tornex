defmodule Torngen.Client.Schema.FactionTerritoriesOwnershipResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territoryownership]

  defstruct [
    :territoryownership
  ]

  @type t :: %__MODULE__{
          territoryownership: [Torngen.Client.Schema.FactionTerritoryOwnership.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territoryownership:
        Map.get(data, "territoryownership")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryOwnership})
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

  defp validate_key?(:territoryownership, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryOwnership})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
