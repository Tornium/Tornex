defmodule Torngen.Client.Schema.TornEducationCourses do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rewards, :prerequisites, :name, :id, :duration, :description, :code]

  defstruct [
    :rewards,
    :prerequisites,
    :name,
    :id,
    :duration,
    :description,
    :code
  ]

  @type t :: %__MODULE__{
          rewards: Torngen.Client.Schema.TornEducationRewards.t(),
          prerequisites: Torngen.Client.Schema.TornEducationPrerequisites.t(),
          name: String.t(),
          id: Torngen.Client.Schema.EducationId.t(),
          duration: integer(),
          description: String.t(),
          code: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rewards: Map.get(data, "rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationRewards),
      prerequisites:
        Map.get(data, "prerequisites") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationPrerequisites),
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EducationId),
      duration: Map.get(data, "duration") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string}),
      code: Map.get(data, "code") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:rewards, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornEducationRewards)
  end

  defp validate_key?(:prerequisites, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornEducationPrerequisites)
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.EducationId)
  end

  defp validate_key?(:duration, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:code, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
