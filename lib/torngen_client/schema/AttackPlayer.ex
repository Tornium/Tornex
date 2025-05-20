defmodule Torngen.Client.Schema.AttackPlayer do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :level, :id, :faction]

  defstruct [
    :name,
    :level,
    :id,
    :faction
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          faction: nil | Torngen.Client.Schema.AttackPlayerFaction.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: Map.get(data, "level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction:
        Map.get(data, "faction")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerFaction]})
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

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:level, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:faction, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.AttackPlayerFaction]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
