defmodule Torngen.Client.Schema.RacingTrackRecordsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      records: Map.get(data, "records") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceRecord})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:records, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.RaceRecord})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
