defmodule Torngen.Client.Schema.UserCrimeAttempts do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :success, :subcrimes, :fail, :critical_fail]

  defstruct [
    :total,
    :success,
    :subcrimes,
    :fail,
    :critical_fail
  ]

  @type t :: %__MODULE__{
          total: integer(),
          success: integer(),
          subcrimes: [Torngen.Client.Schema.UserSubcrime.t()],
          fail: integer(),
          critical_fail: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      success: data |> Map.get("success") |> Torngen.Client.Schema.parse({:static, :integer}),
      subcrimes:
        data |> Map.get("subcrimes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserSubcrime}),
      fail: data |> Map.get("fail") |> Torngen.Client.Schema.parse({:static, :integer}),
      critical_fail: data |> Map.get("critical_fail") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:subcrimes, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserSubcrime})
  end

  defp validate_key?(:fail, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:critical_fail, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
