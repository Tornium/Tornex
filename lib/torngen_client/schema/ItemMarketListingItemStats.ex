defmodule Torngen.Client.Schema.ItemMarketListingItemStats do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:quality, :damage, :armor, :accuracy]

  defstruct [
    :quality,
    :damage,
    :armor,
    :accuracy
  ]

  @type t :: %__MODULE__{
          quality: integer() | float(),
          damage: nil | integer() | float(),
          armor: nil | integer() | float(),
          accuracy: nil | integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      quality: Map.get(data, "quality") |> Torngen.Client.Schema.parse({:static, :number}),
      damage: Map.get(data, "damage") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]}),
      armor: Map.get(data, "armor") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]}),
      accuracy: Map.get(data, "accuracy") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :number]})
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

  defp validate_key?(:quality, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:damage, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :number]})
  end

  defp validate_key?(:armor, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :number]})
  end

  defp validate_key?(:accuracy, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :number]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
