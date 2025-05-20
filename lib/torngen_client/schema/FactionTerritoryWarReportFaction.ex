defmodule Torngen.Client.Schema.FactionTerritoryWarReportFaction do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:score, :name, :members, :joins, :is_aggressor, :id, :clears]

  defstruct [
    :score,
    :name,
    :members,
    :joins,
    :is_aggressor,
    :id,
    :clears
  ]

  @type t :: %__MODULE__{
          score: integer(),
          name: String.t(),
          members: [Torngen.Client.Schema.FactionTerritoryWarReportMembers.t()],
          joins: integer(),
          is_aggressor: boolean(),
          id: Torngen.Client.Schema.FactionId.t(),
          clears: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: Map.get(data, "score") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members:
        Map.get(data, "members")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReportMembers}),
      joins: Map.get(data, "joins") |> Torngen.Client.Schema.parse({:static, :integer}),
      is_aggressor: Map.get(data, "is_aggressor") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      clears: Map.get(data, "clears") |> Torngen.Client.Schema.parse({:static, :integer})
    }

    # TODO: Handle default values in schema parser and codegen
  end

  @impl true
  def validate(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key(key, value) end)
    |> Enum.any?()
  end

  defp validate_key(:score, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:members, value) do
    Torngen.Client.Schema.validate(value, {:array, Torngen.Client.Schema.FactionTerritoryWarReportMembers})
  end

  defp validate_key(:joins, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:is_aggressor, value) do
    Torngen.Client.Schema.validate(value, {:static, :boolean})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key(:clears, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
