defmodule Torngen.Client.Schema.FactionOngoingChain do
  @moduledoc false

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
      timeout: data |> Map.get("timeout") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      modifier: data |> Map.get("modifier") |> Torngen.Client.Schema.parse({:static, :number}),
      max: data |> Map.get("max") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ChainId),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      current: data |> Map.get("current") |> Torngen.Client.Schema.parse({:static, :integer}),
      cooldown: data |> Map.get("cooldown") |> Torngen.Client.Schema.parse({:static, :integer})
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
