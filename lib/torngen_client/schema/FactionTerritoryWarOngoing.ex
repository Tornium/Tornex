defmodule Torngen.Client.Schema.FactionTerritoryWarOngoing do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territory, :target, :start, :id, :factions, :end]

  defstruct [
    :territory,
    :target,
    :start,
    :id,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          target: integer(),
          start: integer(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarOngoingFaction.t()],
          end: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory: Map.get(data, "territory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TerritoryWarId),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarOngoingFaction}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryEnum)
  end

  defp validate_key?(:target, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TerritoryWarId)
  end

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryWarOngoingFaction})
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
