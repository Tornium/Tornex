defmodule Torngen.Client.Schema.TornFactionTreeResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:factionTree]

  defstruct [
    :factionTree
  ]

  @type t :: %__MODULE__{
          factionTree: [Torngen.Client.Schema.TornFactionTree.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      factionTree:
        Map.get(data, "factionTree") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornFactionTree})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:factionTree, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornFactionTree})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
