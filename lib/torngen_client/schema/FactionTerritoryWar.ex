defmodule Torngen.Client.Schema.FactionTerritoryWar do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:winner, :war_id, :territory, :target, :start, :factions, :end]

  defstruct [
    :winner,
    :war_id,
    :territory,
    :target,
    :start,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          winner: nil | Torngen.Client.Schema.FactionId.t(),
          war_id: integer(),
          territory: String.t(),
          target: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarParticipant.t()],
          end: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner:
        Map.get(data, "winner")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      war_id: Map.get(data, "war_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      territory: Map.get(data, "territory") |> Torngen.Client.Schema.parse({:static, :string}),
      target: Map.get(data, "target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      factions:
        Map.get(data, "factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarParticipant}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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

  defp validate_key?(:winner, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  defp validate_key?(:war_id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:target, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryWarParticipant})
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
