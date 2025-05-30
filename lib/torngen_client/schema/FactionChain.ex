defmodule Torngen.Client.Schema.FactionChain do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:start, :respect, :id, :end, :chain]

  defstruct [
    :start,
    :respect,
    :id,
    :end,
    :chain
  ]

  @type t :: %__MODULE__{
          start: integer(),
          respect: integer() | float(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          chain: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: data |> Map.get("respect") |> Torngen.Client.Schema.parse({:static, :number}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      chain: data |> Map.get("chain") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ChainId)
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
