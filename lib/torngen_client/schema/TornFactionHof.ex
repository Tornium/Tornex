defmodule Torngen.Client.Schema.TornFactionHof do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:values, :rank, :position, :name, :members, :id]

  defstruct [
    :values,
    :rank,
    :position,
    :name,
    :members,
    :id
  ]

  @type t :: %__MODULE__{
          values: Torngen.Client.Schema.FactionHofValues.t(),
          rank: String.t(),
          position: integer(),
          name: String.t(),
          members: integer(),
          id: Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: Map.get(data, "values") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionHofValues),
      rank: Map.get(data, "rank") |> Torngen.Client.Schema.parse({:static, :string}),
      position: Map.get(data, "position") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      members: Map.get(data, "members") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId)
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

  defp validate_key(:values, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionHofValues)
  end

  defp validate_key(:rank, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:position, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:members, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.FactionId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
