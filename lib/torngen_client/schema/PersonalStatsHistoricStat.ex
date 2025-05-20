defmodule Torngen.Client.Schema.PersonalStatsHistoricStat do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :timestamp, :name]

  defstruct [
    :value,
    :timestamp,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer(),
          timestamp: integer(),
          name: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: Map.get(data, "value") |> Torngen.Client.Schema.parse({:static, :integer}),
      timestamp: Map.get(data, "timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key(:value, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:timestamp, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
