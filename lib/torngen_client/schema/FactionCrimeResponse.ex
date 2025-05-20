defmodule Torngen.Client.Schema.FactionCrimeResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:crime]

  defstruct [
    :crime
  ]

  @type t :: %__MODULE__{
          crime: Torngen.Client.Schema.FactionCrime.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      crime: data |> Map.get("crime") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionCrime)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:crime, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionCrime)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
