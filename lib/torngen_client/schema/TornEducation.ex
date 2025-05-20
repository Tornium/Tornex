defmodule Torngen.Client.Schema.TornEducation do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :id, :courses]

  defstruct [
    :name,
    :id,
    :courses
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          id: integer(),
          courses: [Torngen.Client.Schema.TornEducationCourses.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse({:static, :integer}),
      courses:
        Map.get(data, "courses") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornEducationCourses})
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:courses, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornEducationCourses})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
