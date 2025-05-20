defmodule Torngen.Client.Schema.FactionTerritoryOwnership do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:owned_by, :id, :acquired_at]

  defstruct [
    :owned_by,
    :id,
    :acquired_at
  ]

  @type t :: %__MODULE__{
          owned_by: nil | Torngen.Client.Schema.FactionId.t(),
          id: String.t(),
          acquired_at: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      owned_by:
        Map.get(data, "owned_by")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :string}),
      acquired_at:
        Map.get(data, "acquired_at") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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

  defp validate_key(:owned_by, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionId]})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:acquired_at, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
