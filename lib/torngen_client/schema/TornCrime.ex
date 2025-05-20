defmodule Torngen.Client.Schema.TornCrime do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :unique_outcomes_ids,
    :unique_outcomes_count,
    :notes,
    :name,
    :id,
    :enhancer_name,
    :enhancer_id,
    :category_name,
    :category_id
  ]

  defstruct [
    :unique_outcomes_ids,
    :unique_outcomes_count,
    :notes,
    :name,
    :id,
    :enhancer_name,
    :enhancer_id,
    :category_name,
    :category_id
  ]

  @type t :: %__MODULE__{
          unique_outcomes_ids: [integer()],
          unique_outcomes_count: integer(),
          notes: [String.t()],
          name: String.t(),
          id: Torngen.Client.Schema.TornCrimeId.t(),
          enhancer_name: String.t(),
          enhancer_id: integer(),
          category_name: String.t(),
          category_id: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      unique_outcomes_ids:
        Map.get(data, "unique_outcomes_ids") |> Torngen.Client.Schema.parse({:array, {:static, :integer}}),
      unique_outcomes_count: Map.get(data, "unique_outcomes_count") |> Torngen.Client.Schema.parse({:static, :integer}),
      notes: Map.get(data, "notes") |> Torngen.Client.Schema.parse({:array, {:static, :string}}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornCrimeId),
      enhancer_name: Map.get(data, "enhancer_name") |> Torngen.Client.Schema.parse({:static, :string}),
      enhancer_id: Map.get(data, "enhancer_id") |> Torngen.Client.Schema.parse({:static, :integer}),
      category_name: Map.get(data, "category_name") |> Torngen.Client.Schema.parse({:static, :string}),
      category_id: Map.get(data, "category_id") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:unique_outcomes_ids, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:static, :integer}})
  end

  defp validate_key?(:unique_outcomes_count, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:notes, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:static, :string}})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornCrimeId)
  end

  defp validate_key?(:enhancer_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:enhancer_id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:category_name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:category_id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
