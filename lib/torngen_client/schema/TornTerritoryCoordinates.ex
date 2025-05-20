defmodule Torngen.Client.Schema.TornTerritoryCoordinates do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:y, :x]

  defstruct [
    :y,
    :x
  ]

  @type t :: %__MODULE__{
          y: integer() | float(),
          x: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      y: Map.get(data, "y") |> Torngen.Client.Schema.parse({:static, :number}),
      x: Map.get(data, "x") |> Torngen.Client.Schema.parse({:static, :number})
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

  defp validate_key(:y, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  defp validate_key(:x, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
