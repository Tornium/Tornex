defmodule Torngen.Client.Schema.FactionChainReportAttackerRespect do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :number}),
      best: Map.get(data, "best") |> Torngen.Client.Schema.parse({:static, :number}),
      average: Map.get(data, "average") |> Torngen.Client.Schema.parse({:static, :number})
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

  defp validate_key(:total, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  defp validate_key(:best, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  defp validate_key(:average, value) do
    Torngen.Client.Schema.validate(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
