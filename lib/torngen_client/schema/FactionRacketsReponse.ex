defmodule Torngen.Client.Schema.FactionRacketsReponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rackets]

  defstruct [
    :rackets
  ]

  @type t :: %__MODULE__{
          rackets: [Torngen.Client.Schema.TornRacket.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rackets: data |> Map.get("rackets") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornRacket})
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

  defp validate_key?(:rackets, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornRacket})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
