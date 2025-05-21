defmodule Torngen.Client.Schema.FactionTerritoryWarReport do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:winner, :territory, :started_at, :result, :id, :factions, :ended_at]

  defstruct [
    :winner,
    :territory,
    :started_at,
    :result,
    :id,
    :factions,
    :ended_at
  ]

  @type t :: %__MODULE__{
          winner: Torngen.Client.Schema.FactionId.t(),
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          started_at: integer(),
          result: String.t(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          factions: [Torngen.Client.Schema.FactionTerritoryWarReportFaction.t()],
          ended_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      winner: data |> Map.get("winner") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      territory:
        data |> Map.get("territory") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      started_at: data |> Map.get("started_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: data |> Map.get("result") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TerritoryWarId),
      factions:
        data
        |> Map.get("factions")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReportFaction}),
      ended_at: data |> Map.get("ended_at") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:winner, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryEnum)
  end

  defp validate_key?(:started_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:result, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TerritoryWarId)
  end

  defp validate_key?(:factions, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryWarReportFaction})
  end

  defp validate_key?(:ended_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
