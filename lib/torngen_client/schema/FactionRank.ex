defmodule Torngen.Client.Schema.FactionRank do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:wins, :position, :name, :level, :division]

  defstruct [
    :wins,
    :position,
    :name,
    :level,
    :division
  ]

  @type t :: %__MODULE__{
          wins: integer(),
          position: integer(),
          name: String.t(),
          level: integer(),
          division: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wins: data |> Map.get("wins") |> Torngen.Client.Schema.parse({:static, :integer}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      division: data |> Map.get("division") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:wins, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:division, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
