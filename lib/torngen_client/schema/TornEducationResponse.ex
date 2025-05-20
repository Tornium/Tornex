defmodule Torngen.Client.Schema.TornEducationResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:education]

  defstruct [
    :education
  ]

  @type t :: %__MODULE__{
          education: [Torngen.Client.Schema.TornEducation.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      education:
        Map.get(data, "education") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornEducation})
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

  defp validate_key?(:education, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornEducation})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
