defmodule Torngen.Client.Schema.FactionRankedWarResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rankedwars, :_metadata]

  defstruct [
    :rankedwars,
    :_metadata
  ]

  @type t :: %__MODULE__{
          rankedwars: [Torngen.Client.Schema.FactionRankedWarDetails.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rankedwars:
        data
        |> Map.get("rankedwars")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRankedWarDetails}),
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

  defp validate_key?(:rankedwars, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionRankedWarDetails})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
