defmodule Torngen.Client.Schema.TornLookupResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:selections]

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.TornSelectionName.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      selections:
        Map.get(data, "selections") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornSelectionName})
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

  defp validate_key?(:selections, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornSelectionName})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
