defmodule Torngen.Client.Schema.FactionRank do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      wins: Map.get(data, "wins") |> Torngen.Client.Schema.parse({:static, :integer}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      division: Map.get(data, "division") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end

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
