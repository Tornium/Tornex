defmodule Torngen.Client.Schema.UserCrimeAttempts do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      success: Map.get(data, "success") |> Torngen.Client.Schema.parse({:static, :integer}),
      subcrimes:
        Map.get(data, "subcrimes") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserSubcrime}),
      fail: Map.get(data, "fail") |> Torngen.Client.Schema.parse({:static, :integer}),
      critical_fail: Map.get(data, "critical_fail") |> Torngen.Client.Schema.parse({:static, :integer})
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
