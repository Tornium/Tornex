defmodule Torngen.Client.Schema.FactionTerritoryWarReportMembers do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:username, :score, :level, :joins, :id, :clears]

  defstruct [
    :username,
    :score,
    :level,
    :joins,
    :id,
    :clears
  ]

  @type t :: %__MODULE__{
          username: String.t(),
          score: integer(),
          level: integer(),
          joins: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          clears: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      username: data |> Map.get("username") |> Torngen.Client.Schema.parse({:static, :string}),
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      joins: data |> Map.get("joins") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      clears: data |> Map.get("clears") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:username, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:joins, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key?(:clears, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
