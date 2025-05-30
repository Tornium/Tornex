defmodule Torngen.Client.Schema.TornEducationCourses do
  @moduledoc false

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
      rewards: data |> Map.get("rewards") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationRewards),
      prerequisites:
        data
        |> Map.get("prerequisites")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornEducationPrerequisites),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EducationId),
      duration: data |> Map.get("duration") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      code: data |> Map.get("code") |> Torngen.Client.Schema.parse({:static, :string})
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
