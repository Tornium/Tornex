defmodule Torngen.Client.Schema.AttackLogSummary do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :misses, :id, :hits, :damage]

  defstruct [
    :name,
    :misses,
    :id,
    :hits,
    :damage
  ]

  @type t :: %__MODULE__{
          name: nil | String.t(),
          misses: integer(),
          id: nil | Torngen.Client.Schema.UserId.t(),
          hits: integer(),
          damage: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      misses: data |> Map.get("misses") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]}),
      hits: data |> Map.get("hits") |> Torngen.Client.Schema.parse({:static, :integer}),
      damage: data |> Map.get("damage") |> Torngen.Client.Schema.parse({:static, :integer})
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:misses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserId]})
  end

  defp validate_key?(:hits, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:damage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
