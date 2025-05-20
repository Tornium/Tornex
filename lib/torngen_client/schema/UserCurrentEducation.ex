defmodule Torngen.Client.Schema.UserCurrentEducation do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:until, :id]

  defstruct [
    :until,
    :id
  ]

  @type t :: %__MODULE__{
          until: integer(),
          id: Torngen.Client.Schema.EducationId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      until: Map.get(data, "until") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EducationId)
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

  defp validate_key(:until, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.EducationId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
