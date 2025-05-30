defmodule Torngen.Client.Schema.UserCrimeUniquesRewardMoney do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:min, :max]

  defstruct [
    :min,
    :max
  ]

  @type t :: %__MODULE__{
          min: integer(),
          max: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      min: data |> Map.get("min") |> Torngen.Client.Schema.parse({:static, :integer}),
      max: data |> Map.get("max") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:min, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:max, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
