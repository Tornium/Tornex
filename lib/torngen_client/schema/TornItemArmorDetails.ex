defmodule Torngen.Client.Schema.TornItemArmorDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:coverage, :base_stats]

  defstruct [
    :coverage,
    :base_stats
  ]

  @type t :: %__MODULE__{
          coverage: [Torngen.Client.Schema.TornItemArmorCoverage.t()],
          base_stats: Torngen.Client.Schema.TornItemBaseStats.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      coverage:
        data
        |> Map.get("coverage")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemArmorCoverage}),
      base_stats: data |> Map.get("base_stats") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemBaseStats)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:coverage, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItemArmorCoverage})
  end

  defp validate_key?(:base_stats, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemBaseStats)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
