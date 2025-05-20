defmodule Torngen.Client.Schema.TornItemModsResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      itemmods: Map.get(data, "itemmods") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemMods})
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

  defp validate_key(:itemmods, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.TornItemMods})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
