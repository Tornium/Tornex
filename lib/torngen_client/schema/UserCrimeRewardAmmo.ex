defmodule Torngen.Client.Schema.UserCrimeRewardAmmo do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:standard, :special]

  defstruct [
    :standard,
    :special
  ]

  @type t :: %__MODULE__{
          standard: integer(),
          special: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      standard: data |> Map.get("standard") |> Torngen.Client.Schema.parse({:static, :integer}),
      special: data |> Map.get("special") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:standard, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:special, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
