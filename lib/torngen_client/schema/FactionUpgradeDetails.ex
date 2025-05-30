defmodule Torngen.Client.Schema.FactionUpgradeDetails do
  @moduledoc false

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
      unlocked_at: data |> Map.get("unlocked_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionBranchId),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer}),
      ability: data |> Map.get("ability") |> Torngen.Client.Schema.parse({:static, :string})
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
