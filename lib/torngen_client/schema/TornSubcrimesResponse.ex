defmodule Torngen.Client.Schema.TornSubcrimesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:subcrimes]

  defstruct [
    :subcrimes
  ]

  @type t :: %__MODULE__{
          subcrimes: [Torngen.Client.Schema.TornSubcrime.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      subcrimes: Map.get(data, "subcrimes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornSubcrime})
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

  defp validate_key?(:subcrimes, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornSubcrime})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
