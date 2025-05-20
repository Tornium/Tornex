defmodule Torngen.Client.Schema.AttackPlayerSimplified do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:id, :faction_id]

  defstruct [
    :id,
    :faction_id
  ]

  @type t :: %__MODULE__{
          id: Torngen.Client.Schema.UserId.t(),
          faction_id: nil | Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserId),
      faction_id:
        Map.get(data, "faction_id")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
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

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.UserId)
  end

  defp validate_key(:faction_id, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
