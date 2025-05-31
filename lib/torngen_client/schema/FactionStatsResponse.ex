defmodule Torngen.Client.Schema.FactionStatsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stats]

  defstruct [
    :stats
  ]

  @type t :: %__MODULE__{
          stats: [Torngen.Client.Schema.FactionStat.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stats: data |> Map.get("stats") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionStat})
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

  defp validate_key?(:stats, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionStat})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
