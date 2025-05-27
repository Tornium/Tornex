defmodule Torngen.Client.Schema.FactionSearchResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:search, :_metadata]

  defstruct [
    :search,
    :_metadata
  ]

  @type t :: %__MODULE__{
          search: [Torngen.Client.Schema.FactionSearch.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      search: data |> Map.get("search") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionSearch}),
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

  defp validate_key?(:search, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionSearch})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
