defmodule Torngen.Client.Schema.TornCalendarActivity do
  @moduledoc """
  [SHORT DESCRIPTION]
  """

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :start, :end, :description]

  defstruct [
    :title,
    :start,
    :end,
    :description
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          start: integer(),
          end: integer(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: Map.get(data, "title") |> Torngen.Client.Schema.parse({:static, :string}),
      start: Map.get(data, "start") |> Torngen.Client.Schema.parse({:static, :integer}),
      end: Map.get(data, "end") |> Torngen.Client.Schema.parse({:static, :integer}),
      description: Map.get(data, "description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key(:start, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:end, value) do
    Torngen.Client.Schema.validate(value, {:static, :integer})
  end

  defp validate_key(:description, value) do
    Torngen.Client.Schema.validate(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
