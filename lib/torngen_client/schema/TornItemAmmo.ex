defmodule Torngen.Client.Schema.TornItemAmmo do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:types, :price, :name, :id]

  defstruct [
    :types,
    :price,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          types: [Torngen.Client.Schema.TornItemAmmoTypeEnum.t()],
          price: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.AmmoId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      types:
        data |> Map.get("types") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemAmmoTypeEnum}),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AmmoId)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:types, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItemAmmoTypeEnum})
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AmmoId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
