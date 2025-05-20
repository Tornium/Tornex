defmodule Torngen.Client.Schema.TornEducationPrerequisites do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:courses, :cost]

  defstruct [
    :courses,
    :cost
  ]

  @type t :: %__MODULE__{
          courses: [integer()],
          cost: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      courses: Map.get(data, "courses") |> Torngen.Client.Schema.parse({:array, {:static, :integer}}),
      cost: Map.get(data, "cost") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:courses, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:static, :integer}})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
