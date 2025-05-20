defmodule Torngen.Client.Schema.ItemMarketItem do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :name, :id, :average_price]

  defstruct [
    :type,
    :name,
    :id,
    :average_price
  ]

  @type t :: %__MODULE__{
          type: String.t(),
          name: String.t(),
          id: Torngen.Client.Schema.ItemId.t(),
          average_price: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: Map.get(data, "type") |> Torngen.Client.Schema.parse({:static, :string}),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId),
      average_price: Map.get(data, "average_price") |> Torngen.Client.Schema.parse({:static, :integer})
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
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:name, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.ItemId)
  end

  defp validate_key(:average_price, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
