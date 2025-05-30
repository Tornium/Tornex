defmodule Torngen.Client.Schema.UserSubcrime do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :success, :id, :fail]

  defstruct [
    :total,
    :success,
    :id,
    :fail
  ]

  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          id: integer(),
          fail: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      success: data |> Map.get("success") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer}),
      fail: data |> Map.get("fail") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:success, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:fail, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
