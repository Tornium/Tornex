defmodule Torngen.Client.Schema.UserSubcrime do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

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
      total: Map.get(data, "total") |> Torngen.Client.Schema.parse({:static, :integer}),
      success: Map.get(data, "success") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      fail: Map.get(data, "fail") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key(:total, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:success, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:fail, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
