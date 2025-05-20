defmodule Torngen.Client.Schema.FactionUpgradeDetails do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:unlocked_at, :name, :level, :id, :cost, :ability]

  defstruct [
    :unlocked_at,
    :name,
    :level,
    :id,
    :cost,
    :ability
  ]

  @type t :: %__MODULE__{
          unlocked_at: integer(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.FactionBranchId.t(),
          cost: integer(),
          ability: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unlocked_at: Map.get(data, "unlocked_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchId),
      cost: Map.get(data, "cost") |> Torngen.Client.Schema.parse({:static, :integer}),
      ability: Map.get(data, "ability") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:unlocked_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionBranchId)
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:ability, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
