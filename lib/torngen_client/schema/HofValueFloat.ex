defmodule Torngen.Client.Schema.HofValueFloat do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :rank]

  defstruct [
    :value,
    :rank
  ]

  @type t :: %__MODULE__{
          value: integer() | float(),
          rank: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse({:static, :number}),
      rank: data |> Map.get("rank") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
