defmodule Torngen.Client.Schema.TornItemModsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:itemmods]

  defstruct [
    :itemmods
  ]

  @type t :: %__MODULE__{
          itemmods: [Torngen.Client.Schema.TornItemMods.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      itemmods: data |> Map.get("itemmods") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemMods})
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

  defp validate_key?(:itemmods, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItemMods})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
