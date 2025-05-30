defmodule Torngen.Client.Schema.RacingTrackRecordsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:records]

  defstruct [
    :records
  ]

  @type t :: %__MODULE__{
          records: [Torngen.Client.Schema.RaceRecord.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      records: data |> Map.get("records") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceRecord})
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

  defp validate_key?(:records, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.RaceRecord})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
