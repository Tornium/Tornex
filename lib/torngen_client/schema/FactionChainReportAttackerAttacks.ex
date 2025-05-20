defmodule Torngen.Client.Schema.FactionChainReportAttackerAttacks do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  defstruct [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  @type t :: %__MODULE__{
          war: integer(),
          total: integer(),
          retaliations: integer(),
          overseas: integer(),
          mug: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          bonuses: integer(),
          assists: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: Map.get(data, "war") |> Torngen.Client.Schema.parse({:static, :integer}),
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      retaliations: Map.get(data, "retaliations") |> Torngen.Client.Schema.parse({:static, :integer}),
      overseas: Map.get(data, "overseas") |> Torngen.Client.Schema.parse({:static, :integer}),
      mug: Map.get(data, "mug") |> Torngen.Client.Schema.parse({:static, :integer}),
      losses: Map.get(data, "losses") |> Torngen.Client.Schema.parse({:static, :integer}),
      leave: Map.get(data, "leave") |> Torngen.Client.Schema.parse({:static, :integer}),
      hospitalize: Map.get(data, "hospitalize") |> Torngen.Client.Schema.parse({:static, :integer}),
      escapes: Map.get(data, "escapes") |> Torngen.Client.Schema.parse({:static, :integer}),
      draws: Map.get(data, "draws") |> Torngen.Client.Schema.parse({:static, :integer}),
      bonuses: Map.get(data, "bonuses") |> Torngen.Client.Schema.parse({:static, :integer}),
      assists: Map.get(data, "assists") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:war, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:retaliations, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:overseas, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:mug, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:losses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:leave, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:hospitalize, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:escapes, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:draws, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:bonuses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:assists, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
