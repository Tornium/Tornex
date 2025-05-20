defmodule Torngen.Client.Schema.TornLogCategoriesResponse do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:logcategories]

  defstruct [
    :logcategories
  ]

  @type t :: %__MODULE__{
          logcategories: [Torngen.Client.Schema.TornLogCategory.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      logcategories:
        Map.get(data, "logcategories") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornLogCategory})
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

  defp validate_key?(:logcategories, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornLogCategory})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
