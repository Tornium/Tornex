defmodule Torngen.Client.Schema.ForumThreadsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:threads, :_metadata]

  defstruct [
    :threads,
    :_metadata
  ]

  @type t :: %__MODULE__{
          threads: [Torngen.Client.Schema.ForumThreadBase.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      threads: Map.get(data, "threads") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.ForumThreadBase}),
      _metadata:
        Map.get(data, "_metadata") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
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

  defp validate_key(:threads, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.ForumThreadBase})
  end

  defp validate_key(:_metadata, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
