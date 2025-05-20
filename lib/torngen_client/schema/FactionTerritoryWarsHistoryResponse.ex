defmodule Torngen.Client.Schema.FactionTerritoryWarsHistoryResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territorywars]

  defstruct [
    :territorywars
  ]

  @type t :: %__MODULE__{
          territorywars: [Torngen.Client.Schema.FactionTerritoryWarFinished.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territorywars:
        data
        |> Map.get("territorywars")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarFinished})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:territorywars, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionTerritoryWarFinished})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
