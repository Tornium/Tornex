defmodule Torngen.Client.Schema.RequestLinks do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:prev, :next]

  defstruct [
    :prev,
    :next
  ]

  @type t :: %__MODULE__{
          prev: nil | String.t(),
          next: nil | String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      prev: Map.get(data, "prev") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      next: Map.get(data, "next") |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]})
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

  defp validate_key?(:prev, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:next, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
