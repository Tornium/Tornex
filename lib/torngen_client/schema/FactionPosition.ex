defmodule Torngen.Client.Schema.FactionPosition do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :is_default, :abilities]

  defstruct [
    :name,
    :is_default,
    :abilities
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          is_default: boolean(),
          abilities: [Torngen.Client.Schema.FactionPositionAbilityEnum.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_default: data |> Map.get("is_default") |> Torngen.Client.Schema.parse({:static, :boolean}),
      abilities:
        data
        |> Map.get("abilities")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionPositionAbilityEnum})
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:is_default, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:abilities, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionPositionAbilityEnum})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
