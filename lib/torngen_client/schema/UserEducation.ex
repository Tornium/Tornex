defmodule Torngen.Client.Schema.UserEducation do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:current, :complete]

  defstruct [
    :current,
    :complete
  ]

  @type t :: %__MODULE__{
          current: nil | Torngen.Client.Schema.UserCurrentEducation.t(),
          complete: [Torngen.Client.Schema.EducationId.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      current:
        Map.get(data, "current")
        |> Torngen.Client.Schema.parse({:one_of, [{:static, :null}, Torngen.Client.Schema.UserCurrentEducation]}),
      complete: Map.get(data, "complete") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.EducationId})
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

  defp validate_key?(:current, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [{:static, :null}, Torngen.Client.Schema.UserCurrentEducation]})
  end

  defp validate_key?(:complete, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.EducationId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
