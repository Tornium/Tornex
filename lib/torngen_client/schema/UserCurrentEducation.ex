defmodule Torngen.Client.Schema.UserCurrentEducation do
  @moduledoc false

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
      until: data |> Map.get("until") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EducationId)
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

  defp validate_key?(:until, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.EducationId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
