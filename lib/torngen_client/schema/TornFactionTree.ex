defmodule Torngen.Client.Schema.TornFactionTree do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :branches]

  defstruct [
    :name,
    :branches
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          branches: [Torngen.Client.Schema.TornFactionTreeBranch.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: Map.get(data, "name") |> Torngen.Client.Schema.parse({:static, :string}),
      branches:
        Map.get(data, "branches") |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornFactionTreeBranch})
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

  defp validate_key?(:branches, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornFactionTreeBranch})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
