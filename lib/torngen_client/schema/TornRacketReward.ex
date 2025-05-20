defmodule Torngen.Client.Schema.TornRacketReward do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :quantity, :id]

  defstruct [
    :type,
    :quantity,
    :id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.TornRacketType.t(),
          quantity: integer(),
          id: nil | Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornRacketType),
      quantity: Map.get(data, "quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        Map.get(data, "id") |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.ItemId]})
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

  defp validate_key(:type, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.TornRacketType)
  end

  defp validate_key(:quantity, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.ItemId]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
