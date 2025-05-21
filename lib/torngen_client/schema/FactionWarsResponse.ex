defmodule Torngen.Client.Schema.FactionWarsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:wars, :pacts]

  defstruct [
    :wars,
    :pacts
  ]

  @type t :: %__MODULE__{
          wars: Torngen.Client.Schema.FactionWars.t(),
          pacts: [Torngen.Client.Schema.FactionPact.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wars: data |> Map.get("wars") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionWars),
      pacts: data |> Map.get("pacts") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionPact})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:wars, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionWars)
  end

  defp validate_key?(:pacts, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionPact})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
