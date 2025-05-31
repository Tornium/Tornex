defmodule Torngen.Client.Schema.TornItemsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:items]

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: [Torngen.Client.Schema.TornItem.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items: data |> Map.get("items") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItem})
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

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItem})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
