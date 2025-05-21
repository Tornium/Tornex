defmodule Torngen.Client.Schema.UserEducationResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:education]

  defstruct [
    :education
  ]

  @type t :: %__MODULE__{
          education: Torngen.Client.Schema.UserEducation.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      education: data |> Map.get("education") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.UserEducation)
    }
  end

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:education, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.UserEducation)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
