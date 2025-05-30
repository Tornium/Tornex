defmodule Torngen.Client.Schema.FactionChainReportAttackerRespect do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :best, :average]

  defstruct [
    :total,
    :best,
    :average
  ]

  @type t :: %__MODULE__{
          total: integer() | float(),
          best: integer() | float(),
          average: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :number}),
      best: data |> Map.get("best") |> Torngen.Client.Schema.parse({:static, :number}),
      average: data |> Map.get("average") |> Torngen.Client.Schema.parse({:static, :number})
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
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:best, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:average, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
