defmodule Torngen.Client.Schema.TornRacket do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:reward, :name, :level, :description, :created_at, :changed_at]

  defstruct [
    :reward,
    :name,
    :level,
    :description,
    :created_at,
    :changed_at
  ]

  @type t :: %__MODULE__{
          reward: Torngen.Client.Schema.TornRacketReward.t(),
          name: String.t(),
          level: integer(),
          description: String.t(),
          created_at: integer(),
          changed_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      reward: data |> Map.get("reward") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornRacketReward),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      created_at: data |> Map.get("created_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      changed_at: data |> Map.get("changed_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:reward, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornRacketReward)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:created_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:changed_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
