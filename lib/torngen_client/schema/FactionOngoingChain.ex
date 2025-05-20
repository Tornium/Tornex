defmodule Torngen.Client.Schema.FactionOngoingChain do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timeout, :start, :modifier, :max, :id, :end, :current, :cooldown]

  defstruct [
    :timeout,
    :start,
    :modifier,
    :max,
    :id,
    :end,
    :current,
    :cooldown
  ]

  @type t :: %__MODULE__{
          timeout: integer(),
          start: integer(),
          modifier: integer() | float(),
          max: integer(),
          id: Torngen.Client.Schema.ChainId.t(),
          end: integer(),
          current: integer(),
          cooldown: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timeout: Map.get(data, "timeout") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      modifier: Map.get(data, "modifier") |> Torngen.Client.Schema.parse({:static, :number}),
      max: Map.get(data, "max") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer}),
      current: Map.get(data, "current") |> Torngen.Client.Schema.parse({:static, :integer}),
      cooldown: Map.get(data, "cooldown") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:timeout, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:modifier, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:max, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ChainId)
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:current, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cooldown, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
