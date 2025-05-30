defmodule Torngen.Client.Schema.FactionTerritoriesOwnershipResponse do
  @moduledoc false

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
        data
        |> Map.get("territoryownership")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryOwnership})
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

  defp validate_key?(:territoryownership, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryOwnership})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
