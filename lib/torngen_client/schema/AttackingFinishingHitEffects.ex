defmodule Torngen.Client.Schema.AttackingFinishingHitEffects do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :name]

  defstruct [
    :value,
    :name
  ]

  @type t :: %__MODULE__{
          value: integer(),
          name: Torngen.Client.Schema.AttackFinishingHitEffect.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.AttackFinishingHitEffect)
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.AttackFinishingHitEffect)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
