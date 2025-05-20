defmodule Torngen.Client.Schema.RequestMetadataWithLinks do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:links]

  defstruct [
    :links
  ]

  @type t :: %__MODULE__{
          links: Torngen.Client.Schema.RequestLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      links: Map.get(data, "links") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestLinks)
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

  defp validate_key(:links, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.RequestLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
