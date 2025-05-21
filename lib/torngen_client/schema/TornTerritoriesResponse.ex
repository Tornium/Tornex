defmodule Torngen.Client.Schema.TornTerritoriesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territory, :_metadata]

  defstruct [
    :territory,
    :_metadata
  ]

  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.TornTerritory.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory:
        data |> Map.get("territory") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornTerritory}),
      _metadata:
        data |> Map.get("_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornTerritory})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
