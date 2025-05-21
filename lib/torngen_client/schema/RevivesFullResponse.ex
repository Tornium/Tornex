defmodule Torngen.Client.Schema.RevivesFullResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:revives, :_metadata]

  defstruct [
    :revives,
    :_metadata
  ]

  @type t :: %__MODULE__{
          revives: [Torngen.Client.Schema.ReviveSimplified.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      revives:
        data |> Map.get("revives") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ReviveSimplified}),
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

  defp validate_key?(:revives, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.ReviveSimplified})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
