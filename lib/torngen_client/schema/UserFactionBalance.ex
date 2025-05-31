defmodule Torngen.Client.Schema.UserFactionBalance do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:points, :money]

  defstruct [
    :points,
    :money
  ]

  @type t :: %__MODULE__{
          points: integer(),
          money: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      points: data |> Map.get("points") |> Torngen.Client.Schema.parse({:static, :integer}),
      money: data |> Map.get("money") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:points, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
