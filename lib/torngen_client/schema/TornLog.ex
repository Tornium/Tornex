defmodule Torngen.Client.Schema.TornLog do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :id]

  defstruct [
    :title,
    :id
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.LogId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      id: Map.get(data, "id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.LogId)
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

  defp validate_key(:title, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  defp validate_key(:id, value) do
    Torngen.Client.Schema.validate(value, Torngen.Client.Schema.LogId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
