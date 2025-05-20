defmodule Torngen.Client.Schema.TornHofResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hof, :_metadata]

  defstruct [
    :hof,
    :_metadata
  ]

  @type t :: %__MODULE__{
          hof: [Torngen.Client.Schema.TornHof.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hof: Map.get(data, "hof") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornHof}),
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

  defp validate_key(:hof, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.TornHof})
  end

  defp validate_key(:_metadata, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
