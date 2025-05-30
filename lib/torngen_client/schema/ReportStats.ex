defmodule Torngen.Client.Schema.ReportStats do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :strength, :speed, :dexterity, :defense]

  defstruct [
    :total,
    :strength,
    :speed,
    :dexterity,
    :defense
  ]

  @type t :: %__MODULE__{
          total: nil | integer(),
          strength: nil | integer(),
          speed: nil | integer(),
          dexterity: nil | integer(),
          defense: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      strength:
        data |> Map.get("strength") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      speed: data |> Map.get("speed") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      dexterity:
        data |> Map.get("dexterity") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      defense: data |> Map.get("defense") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:strength, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:speed, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:dexterity, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:defense, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
