defmodule Torngen.Client.Schema.HofValueString do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :rank]

  defstruct [
    :value,
    :rank
  ]

  @type t :: %__MODULE__{
          value: String.t(),
          rank: nil | integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse({:static, :string}),
      rank: data |> Map.get("rank") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :number]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
