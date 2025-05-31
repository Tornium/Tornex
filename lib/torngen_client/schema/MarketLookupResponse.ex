defmodule Torngen.Client.Schema.MarketLookupResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:selections]

  defstruct [
    :selections
  ]

  @type t :: %__MODULE__{
          selections: [Torngen.Client.Schema.MarketSelectionName.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      selections:
        data
        |> Map.get("selections")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.MarketSelectionName})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:selections, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.MarketSelectionName})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
