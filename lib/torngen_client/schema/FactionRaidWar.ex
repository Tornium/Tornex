defmodule Torngen.Client.Schema.FactionRaidWar do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:war_id, :start, :factions, :end]

  defstruct [
    :war_id,
    :start,
    :factions,
    :end
  ]

  @type t :: %__MODULE__{
          war_id: integer(),
          start: integer(),
          factions: [Torngen.Client.Schema.FactionRaidWarParticipant.t()],
          end: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war_id: data |> Map.get("war_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      factions:
        data
        |> Map.get("factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidWarParticipant}),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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

  defp validate_key?(:war_id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionRaidWarParticipant})
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
